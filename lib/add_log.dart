import 'package:flutter/material.dart';
import 'package:temperature_tracker/models/log.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';
import 'package:temperature_tracker/utilities/log_handler.dart';

class AddLogPage extends StatefulWidget {
  @override
  _AddLogPageState createState() => _AddLogPageState();
}

class _AddLogPageState extends State<AddLogPage> {
  double _currentTemperature = 36.5;

  LogHandler logHandler = getIt<LogHandler>();

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
                    setState(() {
                      _currentTemperature = logHandler.updateTemperature(
                          false, _currentTemperature);
                    });
                  },
                ),
                Spacer(),
                Text(
                  '${_currentTemperature.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 100.0),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.add, size: 25.0),
                  onPressed: () {
                    setState(() {
                      _currentTemperature = logHandler.updateTemperature(
                          true, _currentTemperature);
                    });
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

  void addLog() async {
    final Log newLog = Log(_currentTemperature);

    Navigator.of(context).pop(newLog);
  }
}
