import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:disinfection_integration/dataRep.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Robot {
  void setSpeed(double speed, int reqId) async {
    Socket socket = await Socket.connect('192.168.11.1', 1445);
    String arg =
        '{"args": {"param":"base.max_moving_speed", "value":$speed}, "command": "setsystemparameter","request_id": $reqId}\n\r\n\r\n';
    socket.add(utf8.encode(arg));
    socket.close();
  }

  void moveDir(int direction, int reqId) async {
    Socket socket = await Socket.connect('192.168.11.1', 1445);
    String arg =
        '{"args": {"direction":$direction, "options":{"flags":[]}}, "command": "moveby","request_id": $reqId}\n\r\n\r\n';
    socket.add(utf8.encode(arg));

    socket.close();
  }

  Future<int> moveTo(double x, double y) async {
    var completer = new Completer<int>();
    Socket socket = await Socket.connect('192.168.11.1', 1445);

    socket.listen(
      (Uint8List data) {
        ActionID x = JsonMapper.deserialize<ActionID>(utf8.decode(data))!;
        socket.close();
        completer.complete(x.id);
      },
      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },
      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
    String arg =
        '{"args": {"options": {"flags": ["milestone", "precise"]}, "points": [[$x,$y]], "yaw": 3.14}, "command": "moveto", "request_id": 101}\n\r\n\r\n';
    socket.add(utf8.encode(arg));
    return completer.future;
  }

  void stop(int reqId) async {
    Socket socket = await Socket.connect('192.168.11.1', 1445);
    String arg =
        '{"args": {"options": {"flags": ["milestone", "precise"]}, "points": [[]], "yaw": 3.14}, "command": "moveto", "request_id": 101}\n\r\n\r\n';
    socket.add(utf8.encode(arg));
    socket.close();
  }

  void goDock() async {
    Socket socket = await Socket.connect('192.168.11.1', 1445);
    String arg =
        '{"args":"dock", "command":"backhome", "request_id":1234}\n\r\n\r\n';
    socket.add(utf8.encode(arg));
    socket.close();
  }

  void getRobotHealth() async {
    Socket socket = await Socket.connect('192.168.11.1', 1445);
    socket.listen((event) {
      String msg = utf8.decode(event);
      print(msg);
    });
    socket.add(utf8.encode(
        '{"args": null, "command": "getrobothealth", "request_id": 101}\n\r\n\r\n'));
    socket.close();
  }

  void getMap() async {
    Socket socket = await Socket.connect('192.168.11.1', 1445);
    socket.listen((event) {
      String msg = utf8.decode(event);
      print(msg);
      final instance = JsonMapper.deserialize<KnownArea>(msg);
      getMap2(
          instance?.height, instance?.width, instance?.minX, instance?.minY);
      socket.close();
    });
    socket.add(utf8.encode(
        '{"args":{"kind":0, "partially":false, "type":0},"command":"getknownarea", "request_id":10234}\n\r\n\r\n'));
  }

  void getMap2(height, width, minX, minY) async {
    var partial = '';
    Socket socket = await Socket.connect('192.168.11.1', 1445,
        timeout: Duration(seconds: 10));
    socket.listen(
      (Uint8List data) {
        partial += utf8.decode(data);
        print('Incoming');
        if (partial.lastIndexOf('\n\r\n\r\n') > 0) {
          print(partial.length);
          MapData myMap = JsonMapper.deserialize<MapData>(partial)!;
          socket.close();
          SharedPreferences.getInstance().then((SharedPreferences prefs) {
            prefs.setString('robotMap',
                '{"args":[{"kind":0,"map":{"dimension_x":${myMap.dimensionX},"dimension_y":${myMap.dimensionY},"map_data":"${myMap.mapData}","real_x":${myMap.realX},"real_y":${myMap.realY},"resolution":${myMap.resolution},"size":${myMap.size},"timestamp":${myMap.timestamp},"type":${myMap.type}},"partially":false,"type":0},{"pitch":0.0,"roll":0.0,"x":0.0,"y":0.0,"yaw":0.0,"z":0.0}],"command":"setmapandpose","request_id":98762}\n\r\n\r\n');
          });
          getWalls();
        }
      },
      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },
      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
    socket.add(utf8.encode(
        '{"args":{"area":{"height":$height,"width":$width,"x":$minX,"y":$minY},"kind":0,"partially":false,"type":0},"command":"getmapdata","request_id":56789}\n\r\n\r\n'));
  }

  void setMap() async {
    Socket socket = await Socket.connect('192.168.11.1', 1445);
    socket.listen(
      (Uint8List data) {
        print(utf8.decode(data));
      },
      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },
      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
    print('setting map');
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      socket.add(utf8.encode(prefs.getString('robotMap') ?? ''));
      socket.add(utf8.encode(prefs.getString('robotWall') ?? ''));
    });
  }

  void clearMap() async {
    Socket socket = await Socket.connect('192.168.11.1', 1445);

    socket.add(utf8.encode(
        '{"args":0,"command":"clearmap","request_id":483789867}\n\r\n\r\n'));
    socket.close();
  }

  void getWalls() async {
    String partial = '';
    Socket socket = await Socket.connect('192.168.11.1', 1445);
    socket.listen(
      (Uint8List data) {
        partial += utf8.decode(data);
        print('Wallsss');
        if (partial.lastIndexOf('\n\r\n\r\n') > 0) {
          print(partial.length);
          VirtualWall myWall = JsonMapper.deserialize<VirtualWall>(partial)!;
          SharedPreferences.getInstance().then((SharedPreferences prefs) {
            prefs.setString('robotWall',
                '{"args":{"lines":"${myWall.lines}","usuage":"virtual_wall"},"command":"addwalls","request_id":32415254}\n\r\n\r\n');
            print(
                '{"args":{"lines":"${myWall.lines}","usuage":"virtual_wall"},"command":"addwalls","request_id":32415254}\n\r\n\r\n');
          });
          socket.close();
        }
      },
      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },
      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
    socket.add(utf8.encode(
        '{"args":0,"command":"getwalls","request_id":483789867}\n\r\n\r\n'));
  }

  Future<bool> getStatus(int id) async {
    var completer = new Completer<bool>();
    Socket socket = await Socket.connect('192.168.11.1', 1445);
    socket.listen(
      (Uint8List data) {
        ActionStatus x = JsonMapper.deserialize(data);
        socket.close();
        return completer.complete(x.status == 'done');
      },
      // handle errors
      onError: (error) {
        print(error);
        socket.destroy();
      },
      // handle server ending connection
      onDone: () {
        print('Server left.');
        socket.destroy();
      },
    );
    socket.add(utf8.encode(
        '{"args":{"id":$id},"command":"actionstatus","request_id":483789867}\n\r\n\r\n'));
    return completer.future;
  }

  void patrol() async {
    int currentId = 0;
    setSpeed(0.15, 20002);
    print('Patroling');
    currentId = await moveTo(3.79, 2.79);
    print(currentId);
    bool done = false;
    while (!done) {
      done = await getStatus(currentId);
    }
    print('reached');
  }
}
