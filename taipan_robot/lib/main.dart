import 'package:flutter/material.dart';
import 'package:taipan_robot/Robot/robotCom.dart';
import 'package:taipan_robot/data/missionManager.dart';
import 'package:taipan_robot/main.reflectable.dart';
import 'package:taipan_robot/widgets/mainPage.dart';
import 'package:taipan_robot/theme/theme.dart';
import 'package:taipan_robot/widgets/taskDialog.dart';

import 'data/mission.dart';

void main() async {
  initializeReflectable();
  ComHandler robotCom = ComHandler();
  await robotCom.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Robot Scheduler',
      theme: CustomTheme.lightTheme,
      home: MyHomePage(title: 'Robot Scheduler Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MissionManager mm = MissionManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Dashboard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task newTask = Task('new', 0, 0);
          displayTaskInputDialog(context, newTask);
          setState(() {
            mm.missions[mm.activeMission].tasks.add(newTask);
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
