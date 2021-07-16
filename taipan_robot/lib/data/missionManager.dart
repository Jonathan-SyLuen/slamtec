import 'dart:async';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taipan_robot/Robot/robotCom.dart';
import 'package:taipan_robot/Robot/sterilizer.dart';
import 'mission.dart';

class MissionManager {
  static final MissionManager _missionManager = MissionManager._internal();
  Sterilizer robotSterilizer = Sterilizer();
  late SharedPreferences prefs;
  late ComHandler robotCom;
  factory MissionManager() {
    return _missionManager;
  }
  Completer<bool> initCompleted = new Completer();

  MissionManager._internal() {
    SharedPreferences.getInstance().then((sp) {
      prefs = sp;
      getMissions();
      initCompleted.complete(true);
    });
    robotCom = ComHandler();
    robotCom.connect();
    robotCom.setRobotMap();
    taskStream.add(-1);
  }
  int get activeMission {
    return _activeMission;
  }

  set activeMission(int index) {
    if (index < missions.length) {
      _activeMission = index;
      prefs.setInt('activeMission', index);
    }
  }

  List<Mission> missions = [];
  int _activeMission = 0;
  Stopwatch missionTimer = new Stopwatch();
  bool taskRunning = false;
  StreamController<int> taskStream = new StreamController.broadcast();

  dispose() {
    taskStream.close();
  }

  void saveMission() {
    String serialized = JsonMapper.serialize(missions[activeMission]);
    print(serialized);
    prefs.setString('mission_$activeMission', serialized);
  }

  void getMissions() {
    for (int i = 0; i < 4; i++) {
      print('Mission $i');
      String str = prefs.getString('mission_$i') ?? '';
      if (str.isEmpty) {
        Mission x = new Mission('Empty mission');
        str = JsonMapper.serialize(x);
        missions.add(x);
      } else {
        Mission x =
            JsonMapper.deserialize<Mission>(str) ?? new Mission('failed');
        missions.add(x);
      }
    }
    _activeMission = prefs.getInt('activeMission') ?? 0;
  }

  void executeMission() async {
    FlutterTts flutterTts = FlutterTts();
    Mission x = missions[activeMission];
    missionTimer.start();
    Timer(x.missionDuration, () {
      taskRunning = false;
      robotCom.stop();
    });
    taskRunning = true;
    await flutterTts.speak(
        'Sterilization Process start soon. Please keep the path clean. Thank you. I will clean ${x.name} routine.');

    while (taskRunning) {
      for (Task task in x.tasks) {
        flutterTts.speak('I am moving to ${task.name}');
        taskStream.add(x.tasks.indexOf(task));
        robotSterilizer.setLight(task.lightOn);
        robotSterilizer.setMist(task.mistOn);
        await robotCom.moveTo(task.positionX, task.positionY, task.speed);
        if (taskRunning == false) {
          break;
        }
        if (robotCom.batteryPercentage < 20) {
          flutterTts.speak('Battery is low, I need a rest.');
          taskRunning = false;
          break;
        }
      }
    }
    taskStream.add(-1);
    missionTimer.stop();
    missionTimer.reset();
    print('Finish execute Mission');
    flutterTts.speak('The mission is canceled or completed. I am moving home');
    robotSterilizer.setLight(false);
    robotSterilizer.setMist(false);
    await robotCom.backHome();
  }
}
