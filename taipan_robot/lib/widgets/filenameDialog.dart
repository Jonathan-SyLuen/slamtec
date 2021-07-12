import 'package:flutter/material.dart';
import 'package:taipan_robot/data/missionManager.dart';

Future<void> displayFileNameDialog(BuildContext context) async {
  String missionName = 'New Mission';
  MissionManager mm = MissionManager();
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Add new Task'),
            content: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: mm.mission.name,
                      onChanged: (value) {
                        setState(() {
                          missionName = value;
                        });
                      },
                      //controller: _textfieldController,
                      decoration: InputDecoration(
                          labelText: 'Mission Name',
                          hintText: 'Provide a name for this routine'),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  mm.mission.name = missionName;
                  mm.saveMission();
                  Navigator.pop(context);
                },
                child: Text('Add Mission'),
              ),
            ],
          );
        });
      });
}
