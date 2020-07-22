import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temperature_tracker/add_log.dart';
import 'package:temperature_tracker/models/log.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LogList _list = LogList();

  void _addLog() async {
    Log newLog = await Navigator.of(context).push(CupertinoPageRoute(
        fullscreenDialog: true, builder: (context) => AddLogPage()));

    setState(() {
      _list.items.add(newLog);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Are you well today?"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _list.items.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text("${_list.items[i].temperatureString()}°C",
                  style: TextStyle(fontSize: 33.0)),
              trailing: Text(_list.items[i].getDateTimeString()),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addLog,
        tooltip: 'Add Log',
        child: Icon(Icons.add),
      ),
    );
  }
}
