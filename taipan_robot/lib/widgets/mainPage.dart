import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:taipan_robot/data/mission.dart';
import 'package:taipan_robot/data/missionManager.dart';
import 'package:taipan_robot/widgets/filenameDialog.dart';
import 'package:taipan_robot/widgets/taskDialog.dart';

import 'StatusReport.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  MissionManager mm = MissionManager();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  child: Text("Execute Mission"),
                  onPressed: () {},
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(12)),
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: ListView.builder(
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
                        }),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      await displayFileNameDialog(context);
                      setState(() {});
                    },
                    child: Text('Save Mission')),
              ],
            ),
          ),
          StatusReport(),
          Expanded(
            child: ReorderableListView.builder(
                onReorder: (oldIndex, newIndex) {
                  final Task t =
                      mm.missions[mm.activeMission].tasks.removeAt(oldIndex);
                  if (newIndex > mm.missions[mm.activeMission].tasks.length) {
                    mm.missions[mm.activeMission].tasks.add(t);
                  } else {
                    mm.missions[mm.activeMission].tasks.insert(newIndex, t);
                  }
                  mm.saveMission();
                },
                shrinkWrap: true,
                itemCount: mm.missions[mm.activeMission].tasks.length,
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
                        mm.missions[mm.activeMission].tasks.removeAt(index);
                      });
                    },
                    child: Card(
                      key: Key('$index'),
                      child: ListTile(
                        title: Text(
                            mm.missions[mm.activeMission].tasks[index].name),
                        subtitle: Text(
                            'X:${mm.missions[mm.activeMission].tasks[index].positionX.toStringAsPrecision(2)} Y:${mm.missions[mm.activeMission].tasks[index].positionY.toStringAsPrecision(2)}\nspeed:${mm.missions[mm.activeMission].tasks[index].speed.toStringAsFixed(2)}'),
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(mm.missions[mm.activeMission].tasks[index]
                                    .lightOn
                                ? (Icons.light_mode)
                                : (Icons.lightbulb)),
                            Icon(mm.missions[mm.activeMission].tasks[index]
                                    .mistOn
                                ? (Icons.shower)
                                : (Icons.format_color_reset)),
                          ],
                        ),
                        onTap: () async {
                          await displayTaskInputDialog(context,
                              mm.missions[mm.activeMission].tasks[index]);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
