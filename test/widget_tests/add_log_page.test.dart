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
import 'package:temperature_tracker/pages/add_log_page.dart';
import 'package:temperature_tracker/utilities/constants.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';

void main() {
  setupDependencies();

  testWidgets('Given user adds a log, it should show Log Editor',
      (WidgetTester tester) async {
    await tester.pumpWidget(AddLogPageWrapper());

    final doneButton = find.byIcon(Icons.done);
    expect(doneButton, findsOneWidget);

    final subtractButton = find.byIcon(Icons.remove);
    expect(subtractButton, findsOneWidget);

    final addButton = find.byIcon(Icons.add);
    expect(addButton, findsOneWidget);

    final titleFinder = find.text(ADD_LOG_PAGE_TITLE);
    expect(titleFinder, findsOneWidget);

    final temperatureFinder = find.text("36.5");
    expect(temperatureFinder, findsOneWidget);
  });

  testWidgets(
      'Given user edits a log, it allows for increment and decrement of temperature',
      (WidgetTester tester) async {
    await tester.pumpWidget(AddLogPageWrapper());

    final subtractButton = find.byIcon(Icons.remove);
    await tester.tap(subtractButton);
    await tester.pump(Duration.zero);

    var temperatureFinder = find.text("36.4");
    tester.ensureVisible(temperatureFinder);
    expect(temperatureFinder, findsOneWidget);

    final addButton = find.byIcon(Icons.add);
    await tester.tap(addButton);
    await tester.tap(addButton);
    await tester.pump(Duration.zero);

    temperatureFinder = find.text("36.6");
    expect(temperatureFinder, findsOneWidget);
  });
}
