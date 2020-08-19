import 'package:flutter/material.dart';
import 'package:temperature_tracker/models/log.dart';
import 'package:temperature_tracker/utilities/constants.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';
import 'package:temperature_tracker/services/log_handler.dart';

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
        title: const Text(ADD_LOG_PAGE_TITLE),
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
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.remove, size: 25.0),
                  onPressed: () {
                    setState(() {
                      _currentTemperature = logHandler.updateTemperature(
                          false, _currentTemperature);
                    });
                  },
                ),
                const Spacer(),
                Text(
                  '${_currentTemperature.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 100.0),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(Icons.add, size: 25.0),
                  onPressed: () {
                    setState(() {
                      _currentTemperature = logHandler.updateTemperature(
                          true, _currentTemperature);
                    });
                  },
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> addLog() async {
    final Log newLog = Log(_currentTemperature);

    Navigator.of(context).pop(newLog);
  }
}

class AddLogPageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddLogPage(),
    );
  }
}
