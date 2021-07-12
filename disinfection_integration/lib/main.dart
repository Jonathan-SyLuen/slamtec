import 'dart:convert';

import 'package:disinfection_integration/robot.dart';
import 'package:disinfection_integration/socket.dart';
import 'package:flutter/material.dart';
import 'main.reflectable.dart';

void main() async {
  initializeReflectable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    Sterlizer myRobot = Sterlizer();
    Robot base = Robot();
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: myRobot.onLight, child: Text('On Light')),
            TextButton(onPressed: myRobot.offLight, child: Text('Off Light')),
            TextButton(onPressed: myRobot.onMist, child: Text('On Mist')),
            TextButton(onPressed: myRobot.offMist, child: Text('Off Mist')),
            TextButton(
                onPressed: () => base.moveDir(0, 12345),
                child: Text('Move Forward')),
            TextButton(
                onPressed: () => base.moveDir(1, 12345),
                child: Text('Move Backward')),
            TextButton(
                onPressed: () => base.moveDir(2, 12345),
                child: Text('Rotate Left')),
            TextButton(
                onPressed: () => base.moveDir(3, 12345),
                child: Text('Rotate Right')),
            TextButton(onPressed: () => base.goDock(), child: Text('Dock')),
            TextButton(
                onPressed: () {
                  base.getMap();
                },
                child: Text('Get Map')),
            // TextButton(
            //     onPressed: () => base.setMap(myMap), child: Text('Set Map')),
            TextButton(onPressed: () => base.setMap(), child: Text('Set Map')),
            TextButton(onPressed: () => base.patrol(), child: Text('Patrol')),
          ],
        ),
      ),
    );
  }
}
