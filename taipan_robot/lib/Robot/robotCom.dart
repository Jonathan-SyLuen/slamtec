import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComHandler {
  static final ComHandler _comHandler = ComHandler._internal();

  factory ComHandler() {
    return _comHandler;
  }

  ComHandler._internal() {
    connect();
  }

  late Socket robotSock;
  StreamController poseStream = new StreamController.broadcast();
  StreamController powerStream = new StreamController.broadcast();
  String partial = '';
  bool mapUpdate = false;
  bool wallUpdate = false;
  int actionID = 0;
  bool isActionDone = false;
  String actionResult = 'Completed';
  KnownArea knownArea = new KnownArea(0, 0, 0, 0);
  int batteryPercentage = 0;
  int localizationQuality = -1;

  void dispose() {
    robotSock.close();
    poseStream.close();
    powerStream.close();
  }

  Future<bool> connect() {
    Completer<bool> result = Completer();
    Socket.connect('192.168.11.1', 1445, timeout: Duration(seconds: 5))
        .then((Socket sock) {
      robotSock = sock;
      result.complete(true);
      robotSock.listen(dataHandler,
          onDone: doneHandler, onError: errorHandler, cancelOnError: true);

      requestRobotPose(10);
      print('Robot Connected');
    }).catchError((err) {
      result.completeError(err);
      print(err);
    });
    return result.future;
  }

  void dataHandler(data) {
    partial = partial + utf8.decode(data);
    if (partial.lastIndexOf('\n\r\n\r\n') == partial.length - 5) {
      List<String> tmp = partial.split('\n\r\n\r\n');
      partial = '';
      tmp.forEach((element) {
        if (element.isNotEmpty) {
          RobotResponse currRes =
              JsonMapper.deserialize<RobotResponse>(element)!;
          switch (currRes.command) {
            case 'getpose':
              RobotPose pose =
                  JsonMapper.deserialize<RobotPose>(currRes.result)!;
              poseStream.add(pose);
              break;
            case 'getpowerstatus':
              RobotPower power =
                  JsonMapper.deserialize<RobotPower>(currRes.result)!;
              powerStream.add(power);
              batteryPercentage = power.batteryPercentage;
              break;
            case 'actionstatus':
              RobotActionStatus actionStatus =
                  JsonMapper.deserialize<RobotActionStatus>(currRes.result)!;
              isActionDone = actionStatus.codestr == 'done';
              actionResult = actionStatus.actionCode[actionStatus.code];
              break;
            case 'getknownarea':
              knownArea = JsonMapper.deserialize<KnownArea>(currRes.result)!;
              knownArea.check = true;
              break;
            case 'getmapdata':
              MapData d = JsonMapper.deserialize<MapData>(currRes.result) ??
                  MapData(0, 0, '', 0, 0, 0, 0, 0, 0);
              SharedPreferences.getInstance().then((SharedPreferences prefs) {
                prefs.setString('robotMap',
                    '{"args":[{"kind":0,"map":{"dimension_x":${d.dimensionX},"dimension_y":${d.dimensionY},"map_data":"${d.mapData}","real_x":${d.realX},"real_y":${d.realY},"resolution":${d.resolution},"size":${d.size},"timestamp":${d.timestamp},"type":${d.type}},"partially":false,"type":0},{"pitch":0.0,"roll":0.0,"x":0.0,"y":0.0,"yaw":0.0,"z":0.0}],"command":"setmapandpose"}\n\r\n\r\n');
              });
              mapUpdate = d.size > 0;
              break;
            case 'getwalls':
              VirtualWall vw = JsonMapper.deserialize<VirtualWall>(element)!;
              SharedPreferences.getInstance().then((SharedPreferences prefs) {
                prefs.setString('robotWall',
                    '{"args":{"lines":"${vw.lines}","usuage":"virtual_wall"},"command":"addwalls"}\n\r\n\r\n');
              });
              wallUpdate = true;
              print('Wall Updated');
              break;
            case 'moveto':
            case 'backhome':
              print(element);
              RobotAction a = JsonMapper.deserialize<RobotAction>(element)!;
              actionID = a.id;
              break;
            case 'setmapandpose':
              mapUpdate = true;
              break;
            case 'getrobothealth':
              print(currRes.result);
              break;
            case 'getlocalizationquality':
              localizationQuality = currRes.result;
              break;
          }
        }
      });
    }
  }

  void doneHandler() {
    robotSock.destroy();
  }

  void errorHandler(error, StackTrace trace) {
    print(error);
  }

  void setRobotMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('robotMap')) {
      String mapSyntax = prefs.getString('robotMap') ?? '';
      if (mapSyntax.length > 0) {
        robotSock.add(utf8.encode(mapSyntax));
      }
    }
    if (prefs.containsKey('robotWall')) {
      String wallSyntax = prefs.getString('robotWall') ?? '';

      if (wallSyntax.length > 0) {
        robotSock.add(utf8.encode(wallSyntax));
      }
    }
  }

  void requestRobotPose(int duration) {
    Timer.periodic(Duration(seconds: duration), (timer) {
      robotSock.add(utf8.encode('{"command":"getpowerstatus"}\n\r\n\r\n'));
      robotSock.add(utf8.encode(
          '{"args":{"kind":0, "partially":false, "type":0},"command":"getknownarea"}\n\r\n\r\n'));
    });
    Timer.periodic(Duration(seconds: 2), (timer) {
      robotSock.add(utf8.encode('{"command":"getpose"}\n\r\n\r\n'));
      robotSock.add(utf8.encode(
          '{"args":{"id":$actionID}, "command":"actionstatus"}\n\r\n\r\n'));
      robotSock
          .add(utf8.encode('{"command":"getlocalizationquality"}\n\r\n\r\n'));
      // robotSock.add(utf8.encode('{"command":"getrobothealth"}\n\r\n\r\n'));
    });
  }

  Future<bool> getMap() async {
    knownArea.check = false;
    await Future.doWhile(() async {
      robotSock.add(utf8.encode(
          '{"args":{"kind":0, "partially":false, "type":0},"command":"getknownarea"}\n\r\n\r\n'));
      await Future.delayed(Duration(seconds: 3));
      return !knownArea.check;
    });
    robotSock.add(utf8.encode(
        '{"args":{"area":{"height":${knownArea.height},"width":${knownArea.width},"x":${knownArea.minX},"y":${knownArea.minY}},"kind":0,"partially":false,"type":0},"command":"getmapdata"}\n\r\n\r\n'));
    robotSock.add(utf8.encode('{"args":0,"command":"getwalls"}\n\r\n\r\n'));
    return true;
  }

  Future backHome() async {
    Completer c = Completer();
    robotSock
        .add(utf8.encode('{"args":"dock", "command":"backhome"}\n\r\n\r\n'));
    isActionDone = false;
    print('Move home');

    await Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 3));
      return !isActionDone;
    });
    print('Reach Home');
    return c.complete();
  }

  void stop() {
    robotSock.add(utf8.encode(
        '{"args":{"id":$actionID},"command":"cancelaction"}\n\r\n\r\n'));
  }

  Future moveTo(double x, double y, double speed) async {
    Completer c = Completer();
    robotSock.add(utf8.encode(
        '{"args": {"param":"base.max_moving_speed", "value":"$speed"}, "command": "setsystemparameter"}\n\r\n\r\n'));
    robotSock.add(utf8.encode(
        '{"args": {"param":"base.max_angular_speed", "value":"${speed * 1.8}"}, "command": "setsystemparameter"}\n\r\n\r\n'));
    robotSock.add(utf8.encode(
        '{"args": {"options": {"flags": ["milestone", "precise"]}, "points": [[$x,$y]], "yaw": 0}, "command": "moveto"}\n\r\n\r\n'));
    isActionDone = false;

    await Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 5));
      return !isActionDone;
    });
    return c.complete();
  }
}

@jsonSerializable
class RobotResponse {
  @JsonProperty(name: 'command')
  String command;

  @JsonProperty(name: 'result')
  var result;

  RobotResponse(this.command, this.result);
}

@jsonSerializable
class RobotPose {
  @JsonProperty(name: 'x')
  double x;

  @JsonProperty(name: 'y')
  double y;

  @JsonProperty(name: 'yaw')
  double yaw;

  RobotPose(this.x, this.y, this.yaw);
}

@jsonSerializable
class RobotActionStatus {
  @JsonProperty(name: 'code')
  int code;

  @JsonProperty(name: 'codestr')
  String codestr;

  List<String> actionCode = [
    'waiting_for_start',
    'running',
    'completed',
    'paused',
    'stopped',
    'error'
  ];

  RobotActionStatus(this.code, this.codestr);
}

@jsonSerializable
class KnownArea {
  @JsonProperty(name: 'max_x')
  double maxX;
  @JsonProperty(name: 'max_y')
  double maxY;
  @JsonProperty(name: 'min_x')
  double minX;
  @JsonProperty(name: 'min_y')
  double minY;
  bool check = false;
  late final double height;
  late final double width;

  KnownArea(this.maxX, this.maxY, this.minX, this.minY) {
    height = maxY - minY;
    width = maxX - minX;
  }
}

@jsonSerializable
class MapData {
  @JsonProperty(name: 'dimension_x')
  int dimensionX;
  @JsonProperty(name: 'dimension_y')
  int dimensionY;
  @JsonProperty(name: 'map_data')
  String mapData;
  @JsonProperty(name: 'real_x')
  double realX;
  @JsonProperty(name: 'real_y')
  double realY;
  @JsonProperty(name: 'resolution')
  double resolution;
  @JsonProperty(name: 'size')
  int size;
  @JsonProperty(name: 'timestamp')
  int timestamp;
  @JsonProperty(name: 'type')
  int type;
  bool check = false;

  MapData(this.dimensionX, this.dimensionY, this.mapData, this.realX,
      this.realY, this.resolution, this.size, this.timestamp, this.type);
}

@jsonSerializable
@Json(name: 'result')
class VirtualWall {
  @JsonProperty(name: 'code')
  int code;
  @JsonProperty(name: 'lines')
  String lines;
  @JsonProperty(name: 'timestamp')
  int timestamp;

  VirtualWall(this.code, this.lines, this.timestamp);
}

@jsonSerializable
class RobotPower {
  @JsonProperty(name: 'batteryPercentage')
  int batteryPercentage;
  @JsonProperty(name: 'dockingStatus')
  String dockingStatus;
  @JsonProperty(name: 'isCharging')
  bool isCharging;

  RobotPower(this.batteryPercentage, this.dockingStatus, this.isCharging);
}

@jsonSerializable
@Json(name: 'result')
class RobotAction {
  @JsonProperty(name: 'id')
  int id;

  @JsonProperty(name: 'action_type')
  int actionType;

  RobotAction(this.actionType, this.id);
}

@jsonSerializable
class RobotHealth {
  @JsonProperty(name: 'hasError')
  bool hasError;

  @JsonProperty(name: 'hasFatal')
  bool hasFatal;

  @JsonProperty(name: 'hasWarning')
  bool hasWarning;

  @JsonProperty(name: 'hasEmergencyStop')
  bool hasEmergencyStop;

  RobotHealth(
      this.hasEmergencyStop, this.hasError, this.hasFatal, this.hasWarning);
}
