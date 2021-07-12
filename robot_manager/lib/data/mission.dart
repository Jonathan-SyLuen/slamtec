import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Mission {
  @JsonProperty(name: 'name')
  String name;
  @JsonProperty(name: 'tasks')
  List<Task> tasks = [];

  Mission(this.name);
  void run() {}
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
