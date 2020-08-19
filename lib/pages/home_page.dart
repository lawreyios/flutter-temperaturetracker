/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:temperature_tracker/pages/add_log_page.dart';
import 'package:temperature_tracker/utilities/constants.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';
import 'package:temperature_tracker/services/log_handler.dart';
import 'package:temperature_tracker/services/temperature_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LogHandler logHandler = getIt<LogHandler>();

  Future<void> _addLog() async {
    final newLog = await Navigator.of(context).push(CupertinoPageRoute(
        fullscreenDialog: true, builder: (context) => AddLogPage()));

    setState(() {
      logHandler.addLog(newLog);
    });
  }

  Color getGradeColor(double temperature) {
    final handler = TemperatureHandler(temperature);
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

                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text(LOG_DELETION_ALERT_TEXT)));
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
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
