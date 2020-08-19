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
import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_tracker/pages/home_page.dart';
import 'package:temperature_tracker/models/log.dart';
import 'package:temperature_tracker/utilities/constants.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';
import 'package:temperature_tracker/services/log_handler.dart';
import 'package:temperature_tracker/services/temperature_handler.dart';
import '../data/mock_data_provider.dart';

void main() {
  setupDependencies();

  final logHandler = getIt<LogHandler>();

  testWidgets(
      'Given user enters home page for the first time, there should not be any logs shown',
      (WidgetTester tester) async {
    await tester.pumpWidget(HomePageWrapper());

    final logListKey = find.byKey(Key(LOG_LIST_KEY));
    expect(logListKey, findsOneWidget);

    final widgetAddLogButton =
        (Widget widget) => widget is FloatingActionButton;

    expect(find.byWidgetPredicate(widgetAddLogButton), findsOneWidget);

    final widgetAppBar = (Widget widget) => widget is AppBar;

    expect(find.byWidgetPredicate(widgetAppBar), findsOneWidget);

    final titleFinder = find.text(HOME_PAGE_TITLE);
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Given user has recorded some logs, there should logs shown',
      (WidgetTester tester) async {
    final mockLogList = MockDataProvider().getMockLogList();

    logHandler.logList.items.clear();

    mockLogList.items.forEach((log) {
      logHandler.addLog(log);
    });

    await tester.pumpWidget(HomePageWrapper());

    _verifyAllLogDetails(logHandler.logList, tester);

    final titleFinder = find.text("You have a Normal Temperature.");
    expect(titleFinder, findsOneWidget);
  });
}

void _verifyAllLogDetails(LogList logList, WidgetTester tester) async {
  for (final log in logList.items) {
    final temperatureReading = find.text("${log.temperatureString()}°C");
    final logTime = find.text("${log.getDateTimeString()}");
    await tester.ensureVisible(temperatureReading);
    expect(temperatureReading, findsOneWidget);
    await tester.ensureVisible(logTime);
    expect(logTime, findsOneWidget);

    final handler = TemperatureHandler(log.temperature);
    expect(
        ((tester.firstWidget(find.text("${log.temperatureString()}°C")) as Text)
                .style)
            .color,
        handler.temperatureColor());
  }
}
