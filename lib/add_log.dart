import 'package:flutter/material.dart';
import 'package:temperature_tracker/models/log.dart';

class AddLogPage extends StatefulWidget {
  @override
  _AddLogPageState createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {
  double _initialTemperature = 36.5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Temperature Log"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: addLog,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                IconButton(
                  icon: Icon(Icons.remove, size: 25.0),
                  onPressed: () {
                    updateTemperature(false);
                  },
                ),
                Spacer(),
                Text(
                  '${_initialTemperature.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 100.0),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add, size: 25.0),
                  onPressed: () {
                    updateTemperature(true);
                  },
                ),
                Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  void updateTemperature(bool isIncrement) {
    setState(() {
      if (isIncrement) {
        _initialTemperature += 0.1;
      } else {
        _initialTemperature -= 0.1;
      }
    });
  }

  void addLog() async {
    final Log newLog = Log(_initialTemperature);

    Navigator.of(context).pop(newLog);
  }
}
