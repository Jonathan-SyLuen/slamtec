import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/material.dart';
import 'package:robot_manager/theme/theme.dart';
import 'data/mission.dart';
import 'widgets/taskDialog.dart';
import 'main.reflectable.dart';

void main() {
  initializeReflectable();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme,
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
  Mission mission = new Mission('Mission 1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () async {
                  Task t = new Task('Current Position', 0, 0);
                  await displayTaskInputDialog(context, t);
                  setState(() {
                    mission.tasks.add(t);
                  });
                },
                child: Text('Testing')),
            TextButton(
              onPressed: savePref,
              child: Text('Save Config'),
            ),
            Expanded(
              child: ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) {
                    print('old $oldIndex, new $newIndex');
                    final Task t = mission.tasks.removeAt(oldIndex);
                    if (newIndex > mission.tasks.length) {
                      mission.tasks.add(t);
                    } else
                      mission.tasks.insert(newIndex, t);
                    mission.tasks.forEach((element) {
                      print(element.name);
                    });
                  },
                  itemCount: mission.tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      key: Key('$index'),
                      title: Text(mission.tasks[index].name),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void savePref() {
    print('Saving preference');
    print(JsonMapper.serialize(mission));
  }
}
