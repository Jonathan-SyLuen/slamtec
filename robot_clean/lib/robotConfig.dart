import 'dart:async';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:robot_clean/robotCom.dart';
import 'package:robot_clean/widgets/taskDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/mission.dart';

class RobotConfig extends StatefulWidget {
  RobotConfig(Key? key, this.robotCom) {
    key = super.key;
  }

  final ComHandler robotCom;

  @override
  _RobotConfigState createState() => _RobotConfigState(robotCom);
}

class _RobotConfigState extends State<RobotConfig> {
  ComHandler robotCom;
  RobotPower powerStatus = RobotPower(0, '', false);
  RobotPose pose = RobotPose(0, 0, 0);
  Mission x = new Mission('Initial Val');

  _RobotConfigState(this.robotCom);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: widget.robotCom.powerStream.stream,
        builder: (context, powerSnapshot) {
          if (powerSnapshot.hasData) {
            powerStatus = powerSnapshot.data as RobotPower;
          }
          return StreamBuilder(
              stream: widget.robotCom.poseStream.stream,
              builder: (context, poseSnapshot) {
                if (poseSnapshot.hasData) {
                  pose = poseSnapshot.data as RobotPose;
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                            onPressed: getMap, child: Text('Get Map')),
                        TextButton(onPressed: () {}, child: Text('Cancle')),
                        TextButton(
                            onPressed: robotCom.backHome, child: Text('Home')),
                        TextButton(
                          child: Text('Add Mission'),
                          onPressed: () async {
                            Task t = new Task('NewTasks', pose.x, pose.y);
                            await displayTaskInputDialog(context, t);
                            setState(() {
                              x.tasks.add(t);
                              saveMission(x);
                            });
                          },
                        ),
                        TextButton(
                          onPressed: x.runLoop,
                          child: Text('Run Loop'),
                        ),
                      ],
                    ),
                    Expanded(
                        child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                                side: BorderSide(
                                    color: Colors.cyanAccent.withOpacity(0.2),
                                    width: 1)),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              leading: Icon(Icons.compass_calibration),
                              title: Text("Robot Pose"),
                              subtitle: Text(
                                  "x: ${pose.x.toStringAsFixed(2)}\ny: ${pose.y.toStringAsFixed(2)}\nyaw: ${pose.yaw.toStringAsFixed(2)}"),
                            )),
                      ],
                    )),
                    Expanded(
                        flex: 1,
                        child: ReorderableListView.builder(
                            shrinkWrap: true,
                            onReorder: (oldIndex, newIndex) {
                              final Task t = x.tasks.removeAt(oldIndex);
                              if (newIndex > x.tasks.length) {
                                x.tasks.add(t);
                              } else {
                                x.tasks.insert(newIndex, t);
                              }
                              //saveMission(x);
                            },
                            itemCount: x.tasks.length,
                            header: Text('Tasks'),
                            padding: EdgeInsets.all(16.0),
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key('$index'),
                                onDismissed: (direction) {
                                  setState(() {
                                    x.tasks.removeAt(index);
                                    //saveMission(x);
                                  });
                                },
                                background: Container(
                                  color: Colors.red,
                                ),
                                child: ListTile(
                                  selectedTileColor: Colors.green,
                                  tileColor: Colors.blue,
                                  key: Key('$index'),
                                  title: Text(x.tasks[index].name),
                                ),
                              );
                            }))
                  ],
                );
              });
        });
  }

  void getMap() async {
    print('Getting Map');
    await widget.robotCom.getKnownArea();
    await widget.robotCom.getMap();
  }

  Future<Mission> getMission() async {
    return Mission('a');
    // Completer<Mission> missionCompleter = new Completer<Mission>();
    // final prefs = await SharedPreferences.getInstance();
    // String missionTxt = prefs.getString('mission_1') ?? '';
    // if (missionTxt.isNotEmpty) {
    //   print('Mission txt = $missionTxt');
    //   Mission tmpMission = JsonMapper.deserialize<Mission>(missionTxt)!;
    //   tmpMission.robot = robotCom;
    //   missionCompleter.complete(tmpMission);
    // } else {
    //   print('No Mission saved');
    //   Mission tmpMission = new Mission('Program 1');
    //   tmpMission.robot = robotCom;
    //   //saveMission(tmpMission);
    //   missionCompleter.complete(tmpMission);
    // }
    // return missionCompleter.future;
  }

  void saveMission(Mission mission) async {
    //final prefs = await SharedPreferences.getInstance();
    //prefs.setString('mission_1', JsonMapper.serialize(mission));
    print('In Save Mission');
    String ser =
        JsonMapper.serialize(mission, SerializationOptions(indent: ''));
    print(ser);
  }
}

class PowerWidget extends StatelessWidget {
  const PowerWidget({
    Key? key,
    required this.rp,
  }) : super(key: key);

  final RobotPower rp;

  @override
  Widget build(BuildContext context) {
    String chargingState = rp.isCharging ? "Charging" : "Discharging";
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 3.75,
      children: [
        Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(
                    color: Colors.cyanAccent.withOpacity(0.2), width: 1)),
            child: ListTile(
              leading: Icon(Icons.battery_full_sharp),
              title: Text("Battery Status"),
              subtitle: Text(rp.batteryPercentage.toString()),
            )),
        Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
                side: BorderSide(
                    color: Colors.cyanAccent.withOpacity(0.2), width: 1)),
            child: ListTile(
              leading: Icon(Icons.battery_full_sharp),
              title: Text("Docking Status"),
              subtitle: Text(rp.dockingStatus + '\n' + chargingState),
            )),
      ],
    );
  }
}
