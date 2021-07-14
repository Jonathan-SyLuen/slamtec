import 'package:flutter/material.dart';
import 'package:taipan_robot/data/missionManager.dart';

Future<void> displayFileNameDialog(BuildContext context) async {
  MissionManager mm = MissionManager();
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Save mission'),
            content: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.3,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: mm.missions[mm.activeMission].name,
                      onChanged: (value) {
                        mm.missions[mm.activeMission].name = value;
                      },
                      //controller: _textfieldController,
                      decoration: InputDecoration(
                          labelText: 'Mission Nick Name',
                          hintText: 'Provide a name for this routine'),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      initialValue: mm
                          .missions[mm.activeMission].missionDuration.inMinutes
                          .toString(),
                      onChanged: (value) {
                        mm.missions[mm.activeMission].missionDuration =
                            Duration(minutes: int.parse(value));
                      },
                      //controller: _textfieldController,
                      decoration: InputDecoration(
                          labelText: 'Mission Duration (minutes)',
                          hintText: 'Must provide a positive number'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // mm.mission.name = missionName;
                  mm.saveMission();
                  Navigator.pop(context);
                },
                child: Text('Save Mission'),
              ),
            ],
          );
        });
      });
}
