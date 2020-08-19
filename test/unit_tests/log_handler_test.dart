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

import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_tracker/models/log.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';
import 'package:temperature_tracker/services/log_handler.dart';

import '../data/mock_data_provider.dart';

void main() {
  setupDependencies();

  final logHandler = getIt<LogHandler>();

  final mockLogList = MockDataProvider().getMockLogList();

  mockLogList.items.forEach((log) {
    logHandler.addLog(log);
  });

  final sortedLogList = logHandler.logList;

  test(
      'Given a list of Temperature Logs, it should be sorted from latest to earliest',
      () async {
    expect(sortedLogList.items.length, equals(4));
    expect(sortedLogList.items[0].temperature, equals(36.8));
    expect(sortedLogList.items[1].temperature, equals(36.7));
    expect(sortedLogList.items[2].temperature, equals(36.6));
    expect(sortedLogList.items[3].temperature, equals(36.5));
  });

  test('Given a new log, it should be added into the list', () async {
    final newLog = Log(40.0);
    newLog.dateTime = DateTime(2020, 10, 1, 10, 4, 1, 0, 0);
    logHandler.addLog(newLog);

    expect(logHandler.logList.items.first.temperature, equals(40.0));
  });

  test(
      'Given that an existing log is removed, it should be removed from the list',
      () async {
    logHandler.removeLog(0);

    expect(logHandler.logList.items.first.temperature, equals(36.8));
  });

  test(
      'Given a list of logs, it should be able to identify the highest temperature',
      () async {
    final highestTemperature = logHandler.getHighestTemperature();

    expect(highestTemperature, equals(36.8));
  });

  test(
      'Given a Log Editor, it should be able to increment or decrement temperature by 0.1',
      () async {
    const baseTemperature = 36.5;

    expect(logHandler.updateTemperature(true, baseTemperature), equals(36.6));
    expect(logHandler.updateTemperature(false, baseTemperature), equals(36.4));
  });
}
