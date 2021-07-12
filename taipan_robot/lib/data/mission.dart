import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Mission {
  @JsonProperty(name: 'name')
  String name;

  @JsonProperty(ignore: true)
  List<Task> tasks = [];

  Mission(this.name);
  void run() {}
}

@jsonSerializable
class Task {
  @JsonProperty(name: 'name')
  String name;

  @JsonProperty(name: 'positionX')
  double positionX;

  @JsonProperty(name: 'positionY')
  double positionY;

  @JsonProperty(name: 'speed')
  double speed = 0.2;

  @JsonProperty(name: 'lightOn')
  bool lightOn = false;

  @JsonProperty(name: 'mistOn')
  bool mistOn = false;

  Task(this.name, this.positionX, this.positionY);
}
