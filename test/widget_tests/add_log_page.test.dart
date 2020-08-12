import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_tracker/add_log.dart';
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
