class Mission {
  String name;
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
