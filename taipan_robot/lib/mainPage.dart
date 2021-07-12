import 'package:flutter/material.dart';
import 'package:taipan_robot/data/missionManager.dart';
import 'package:taipan_robot/widgets/filenameDialog.dart';

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
      child: Column(
        children: [
          TextButton(
            child: Text('Save Mission'),
            onPressed: () {
              displayFileNameDialog(context);
              setState(() {
                mm.getMissions();
              });
            },
          ),
          TextButton(
              child: Text('Get Mission'),
              onPressed: () {
                setState(() {
                  mm.getMissions();
                });
              }),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: mm.missions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(mm.missions[index]),
                  );
                }),
          )
        ],
      ),
    );
  }
}
