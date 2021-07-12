import 'package:flutter/material.dart';
import 'package:robot_clean/robotCom.dart';
import 'package:robot_clean/robotConfig.dart';
import 'package:robot_clean/theme/theme.dart';
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
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ComHandler x = ComHandler();

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
            FutureBuilder(
              future: x.connect(),
              builder: ((context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('None');
                  case ConnectionState.waiting:
                    return Text('waiting');
                  case ConnectionState.active:
                    return Column(
                      children: [
                        CircularProgressIndicator(),
                        Text('Connecting to Robot...'),
                      ],
                    );
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return RobotConfig(widget.key, x);
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return Text('Error Loading Application');
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
