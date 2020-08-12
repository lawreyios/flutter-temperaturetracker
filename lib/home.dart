import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temperature_tracker/add_log.dart';
import 'package:temperature_tracker/models/log.dart';
import 'package:temperature_tracker/utilities/constants.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';
import 'package:temperature_tracker/utilities/log_handler.dart';
import 'package:temperature_tracker/utilities/temperature_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LogHandler logHandler = getIt<LogHandler>();

  void _addLog() async {
    Log newLog = await Navigator.of(context).push(CupertinoPageRoute(
        fullscreenDialog: true, builder: (context) => AddLogPage()));

    setState(() {
      logHandler.addLog(newLog);
    });
  }

  Color getGradeColor(double temperature) {
    TemperatureHandler handler = TemperatureHandler(temperature);
    return handler.temperatureColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(logHandler.getHighestTemperature() == 0.0
            ? HOME_PAGE_TITLE
            : 'You have a ${TemperatureHandler(logHandler.getHighestTemperature()).temperatureGrade()}.'),
      ),
      body: Center(
        child: ListView.builder(
          key: Key(LOG_LIST_KEY),
          itemCount: logHandler.logList.items.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: Key('${logHandler.logList.items[index].id}'),
              onDismissed: (direction) {
                setState(() {
                  logHandler.removeLog(index);
                });

                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text("Log Deleted")));
              },
              background: Container(color: Colors.red),
              child: ListTile(
                title: Text(
                  "${logHandler.logList.items[index].temperatureString()}°C",
                  style: TextStyle(
                    fontSize: 33.0,
                    color: getGradeColor(
                        logHandler.logList.items[index].temperature),
                  ),
                ),
                trailing:
                    Text(logHandler.logList.items[index].getDateTimeString()),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class HomePageWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
