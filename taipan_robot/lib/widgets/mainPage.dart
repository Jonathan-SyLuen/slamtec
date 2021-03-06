import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:taipan_robot/Robot/robotCom.dart';
import 'package:taipan_robot/data/mission.dart';
import 'package:taipan_robot/data/missionManager.dart';
import 'package:taipan_robot/widgets/filenameDialog.dart';
import 'package:taipan_robot/widgets/taskDialog.dart';

import 'dashboardCard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  MissionManager mm = MissionManager();
  ComHandler robotCom = ComHandler();
  RobotPower robotPower = RobotPower(-1, 'Unknown', false);
  RobotPose robotPose = RobotPose(0, 0, 0);
  int taskIndex = -1;
  FlutterTts flutterTts = FlutterTts();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(200, 100)),
                      icon: Icon(Icons.run_circle),
                      label: Text("Execute Mission"),
                      onPressed: () {
                        mm.executeMission();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.home),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 50),
                          primary: Colors.redAccent),
                      label: Text("Terminate Mission"),
                      onPressed: () {
                        mm.taskRunning = false;
                        robotCom.stop();
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(12)),
                    child: SizedBox(
                      height: 250,
                      width: 250,
                      child: FutureBuilder<bool>(
                          future: mm.initCompleted.future,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            }
                            return ListView.builder(
                                itemCount: mm.missions.length,
                                itemBuilder: (context, index) {
                                  return RadioListTile(
                                      title: Text(mm.missions[index].name),
                                      value: index,
                                      groupValue: mm.activeMission,
                                      onChanged: (val) {
                                        setState(() {
                                          mm.activeMission = val as int;
                                        });
                                      });
                                });
                          }),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        await displayFileNameDialog(context);
                        setState(() {});
                      },
                      child: Text('Save Mission')),
                  ElevatedButton(
                    child: Text('Load Map'),
                    onPressed: () async {
                      mm.robotCom.setRobotMap();
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    child: Text('Get Map'),
                    onPressed: () async {
                      print('Getting Map');
                      String map = await mm.robotCom.getMap();
                      final snackBar = SnackBar(
                        content: Text('Map Size ${map.length.toString()}bytes'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder(
            stream: robotCom.powerStream.stream,
            builder: (context, powerSnapshot) {
              if (powerSnapshot.hasData) {
                robotPower = powerSnapshot.data as RobotPower;
              }
              return StreamBuilder(
                  stream: robotCom.poseStream.stream,
                  builder: (context, poseSnapshot) {
                    if (poseSnapshot.hasData) {
                      robotPose = poseSnapshot.data as RobotPose;
                    }
                    return FutureBuilder<bool>(
                        future: mm.initCompleted.future,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          }
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(22.0),
                              child: GridView.count(
                                shrinkWrap: true,
                                mainAxisSpacing: 8,
                                padding: const EdgeInsets.all(22),
                                crossAxisCount: 3,
                                children: [
                                  StatusCard(
                                      robotPower.isCharging
                                          ? Icons.battery_charging_full
                                          : robotPower.batteryPercentage < 40
                                              ? Icons.battery_alert
                                              : Icons.battery_full,
                                      robotPower.isCharging
                                          ? 'Charging ${robotPower.batteryPercentage}%'
                                          : 'Discharging ${robotPower.batteryPercentage}%'),
                                  StatusCard(Icons.assistant_direction,
                                      'x:${robotPose.x.toStringAsFixed(2)}, y:${robotPose.y.toStringAsFixed(2)}\nyaw:${robotPose.yaw.toStringAsFixed(2)}'),
                                  StatusCard(Icons.timelapse,
                                      'Mission ${mm.taskRunning ? 'Running' : 'Stop'}\n${mm.missionTimer.elapsed.toString().split('.').first.padLeft(8, "0")}'),
                                  StatusCard(Icons.timer,
                                      'Mission Time:\n${mm.missions[mm.activeMission].missionDuration.inMinutes} m'),
                                  StatusCard(Icons.map,
                                      'Known Area:\n${robotCom.knownArea.width.toStringAsFixed(2)} x ${robotCom.knownArea.height.toStringAsFixed(2)}'),
                                  StatusCard(Icons.high_quality,
                                      'Map Quality:\n${robotCom.localizationQuality}'),
                                  StatusCard(
                                      robotCom.actionResult == 'completed'
                                          ? Icons.done
                                          : robotCom.actionResult == 'running'
                                              ? Icons.run_circle
                                              : Icons.error,
                                      'Task Status:\n${robotCom.actionResult}'),
                                  GestureDetector(
                                    onTap: () {
                                      mm.robotSterilizer
                                          .setLight(!mm.robotSterilizer.isUvOn);
                                    },
                                    child: StatusCard(
                                        mm.robotSterilizer.isUvOn
                                            ? Icons.light_mode
                                            : Icons.light,
                                        'UV light\n${mm.robotSterilizer.isUvOn ? 'On' : 'Off'}'),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      mm.robotSterilizer.setMist(
                                          !mm.robotSterilizer.isMistOn);
                                    },
                                    child: StatusCard(
                                        mm.robotSterilizer.isMistOn
                                            ? Icons.shower
                                            : Icons.format_color_fill,
                                        'Sterilizer\n${mm.robotSterilizer.isMistOn ? 'On' : 'Off'}'),
                                  ),
                                  StatusCard(Icons.file_download,
                                      'Map File Size: ${mm.robotCom.mapFileSize}'),
                                ],
                              ),
                            ),
                          );
                        });
                  });
            },
          ),
          StreamBuilder<int>(
              stream: mm.taskStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  taskIndex = snapshot.data as int;
                }
                return FutureBuilder<bool>(
                    future: mm.initCompleted.future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      return Expanded(
                        child: ReorderableListView.builder(
                            onReorder: (oldIndex, newIndex) {
                              final Task t = mm.missions[mm.activeMission].tasks
                                  .removeAt(oldIndex);
                              if (newIndex >
                                  mm.missions[mm.activeMission].tasks.length) {
                                mm.missions[mm.activeMission].tasks.add(t);
                              } else {
                                mm.missions[mm.activeMission].tasks
                                    .insert(newIndex, t);
                              }
                              mm.saveMission();
                            },
                            shrinkWrap: true,
                            itemCount:
                                mm.missions[mm.activeMission].tasks.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key('$index'),
                                background: Container(
                                  padding: EdgeInsets.all(20),
                                  alignment: Alignment.centerRight,
                                  color: Colors.red,
                                  child: Icon(Icons.delete),
                                ),
                                onDismissed: (direction) {
                                  setState(() {
                                    mm.missions[mm.activeMission].tasks
                                        .removeAt(index);
                                  });
                                },
                                child: Card(
                                  color: taskIndex == index
                                      ? Colors.amber
                                      : Colors.grey,
                                  key: Key('$index'),
                                  child: ListTile(
                                    title: Text(mm.missions[mm.activeMission]
                                        .tasks[index].name),
                                    subtitle: Text(
                                        'X:${mm.missions[mm.activeMission].tasks[index].positionX.toStringAsPrecision(2)} Y:${mm.missions[mm.activeMission].tasks[index].positionY.toStringAsPrecision(2)}\nspeed:${mm.missions[mm.activeMission].tasks[index].speed.toStringAsFixed(2)}'),
                                    leading: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(mm.missions[mm.activeMission]
                                                .tasks[index].lightOn
                                            ? (Icons.light_mode)
                                            : (Icons.lightbulb)),
                                        Icon(mm.missions[mm.activeMission]
                                                .tasks[index].mistOn
                                            ? (Icons.shower)
                                            : (Icons.format_color_reset)),
                                      ],
                                    ),
                                    onTap: () async {
                                      await displayTaskInputDialog(
                                          context,
                                          mm.missions[mm.activeMission]
                                              .tasks[index]);
                                      setState(() {});
                                    },
                                  ),
                                ),
                              );
                            }),
                      );
                    });
              })
        ],
      ),
    );
  }
}
