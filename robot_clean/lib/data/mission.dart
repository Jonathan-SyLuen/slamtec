import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:robot_clean/sterilizer.dart';

import '../robotCom.dart';

@jsonSerializable
class Mission {
  @JsonProperty(name: 'MissionName')
  String name;
  @JsonProperty(name: 'missionTask')
  List<Task> tasks = [];
  // @JsonProperty(ignore: true)
  // ComHandler robot = ComHandler();
  // @JsonProperty(ignore: true)
  // Sterilizer sterilizer = new Sterilizer();
  // @JsonProperty(ignore: true)
  // Stopwatch sw = new Stopwatch();

  Mission(this.name);
  void runLoop() async {
    // sw.start();
    // for (var task in tasks) {
    //   print('Executing...${task.name}');
    //   sterilizer.setLight(task.lightOn);
    //   sterilizer.setMist(task.mistOn);
    //   await robot.moveTo(task.positionX, task.positionY, task.speed);
    // }
    // sw.stop();
    // print('Finish Run loop');
    // await robot.backHome();
    // print('Home');
  }
}

class Task {
  String name;
  double positionX;
  double positionY;
  double speed = 0.2;
  bool lightOn = false;
  bool mistOn = false;

  Task(this.name, this.positionX, this.positionY);
}
