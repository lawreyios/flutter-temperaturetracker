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
