import 'package:flutter/material.dart';
import 'package:robot_clean/data/mission.dart';

Future<void> displayTaskInputDialog(BuildContext context, Task task) async {
  List<bool> _isSelected = [false, false];
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
                    TextField(
                      onChanged: (value) {
                        task.name = value;
                      },
                      //controller: _textfieldController,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          hintText: 'Provide a name for location'),
                      textInputAction: TextInputAction.next,
                    ),
                    Spacer(flex: 1),
                    TextFormField(
                      initialValue: task.positionX.toString(),
                      onChanged: (value) {
                        task.positionX = double.parse(value);
                      },
                      //controller: _textfieldController,
                      decoration: InputDecoration(labelText: 'Position X'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormField(
                      initialValue: task.positionY.toString(),
                      onChanged: (value) {
                        task.positionY = double.parse(value);
                      },
                      //controller: _textfieldController,
                      decoration: InputDecoration(labelText: 'Position Y'),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    Spacer(flex: 1),
                    Text('Max Moving Speed: ${task.speed} m/s.'),
                    Slider(
                      value: task.speed,
                      min: 0,
                      max: 0.5,
                      label: '${task.speed}',
                      onChanged: (value) {
                        setState(() {
                          task.speed = double.parse(value.toStringAsFixed(2));
                        });
                      },
                      divisions: 10,
                    ),
                    Spacer(flex: 1),
                    ToggleButtons(
                      children: [Icon(Icons.light_mode), Icon(Icons.shower)],
                      isSelected: _isSelected,
                      onPressed: (index) {
                        setState(() {
                          _isSelected[index] = !_isSelected[index];
                          task.lightOn = _isSelected[0];
                          task.mistOn = _isSelected[1];
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Add Task'),
              ),
            ],
          );
        });
      });
}
