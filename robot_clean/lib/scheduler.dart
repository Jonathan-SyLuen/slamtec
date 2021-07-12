import 'dart:async';

import 'package:robot_clean/robotCom.dart';
import 'package:robot_clean/sterilizer.dart';

class Scheduler {
  final ComHandler robotCom;
  final Sterilizer sterilizer;
  List<Mission> tasks = [];
  String missionName = 'Program_1';
  String taskName = '';
  Duration timeout = Duration(minutes: 10);
  Scheduler(this.robotCom, this.sterilizer);
  bool loopOnce = false;
  bool run = false;

  void dispose() {
    print('Scheduler Dispose');
    cancel();
  }

  void runMission() async {
    dummyMission();
    Stopwatch watch = new Stopwatch();
    print('in Mission, $missionName');
    run = true;
    Timer(timeout, () => run = false);
    watch.start();
    while (run) {
      for (var task in tasks) {
        print("Timer elasped for ${watch.elapsed}");
        taskName = task.name;
        print("x: ${task.positionX}, y: ${task.positionY}");
        sterilizer.setLight(task.uvOn);
        sterilizer.setMist(task.mistOn);
        //await robotCom.moveTo(task.positionX, task.positionY, task.speed);
        await Future.delayed(Duration(seconds: 3), () {});
        print('after future');
        //   if (robotCom.batteryPercentage < 20 || loopOnce) {
        //     print('Loop once? $loopOnce');
        //     print('Battery Level: ${robotCom.batteryPercentage}');
        //     run = false;
        //     break;
        //   }
        // }
        print(run);
      }
    }
    sterilizer.setLight(false);
    sterilizer.setMist(false);
    print('going home');
    await robotCom.backHome();
    print('home');
  }

  void cancel() async {
    run = false;
    await robotCom.backHome();
    print('Abort and home');
  }

  void dummyMission() {
    Mission x = Mission('office');
    x.mistOn = true;
    x.uvOn = false;
    x.positionX = 3.79;
    x.positionY = 2.79;
    x.speed = 0.25;

    Mission y = Mission('Natt');
    y.mistOn = false;
    y.uvOn = true;
    y.positionX = 0.3;
    y.positionY = -0.98;
    y.speed = 0.15;

    tasks = [x, y];
  }
}

class Mission {
  final String name;
  double positionX = 0;
  double positionY = 0;
  double speed = 0.2;
  bool uvOn = false;
  bool mistOn = false;

  Mission(this.name);
}
