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

    WidgetPredicate widgetDoneButton = (Widget widget) =>
        widget is IconButton && widget.icon == Icon(Icons.done);

    expect(find.byWidgetPredicate(widgetDoneButton), findsOneWidget);

    WidgetPredicate widgetSubtractButton = (Widget widget) =>
        widget is IconButton && widget.icon == Icon(Icons.remove);

    expect(find.byWidgetPredicate(widgetSubtractButton), findsOneWidget);

    WidgetPredicate widgetAddButton = (Widget widget) =>
        widget is IconButton && widget.icon == Icon(Icons.add);

    expect(find.byWidgetPredicate(widgetAddButton), findsOneWidget);

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

    var temperatureFinder = find.text("36.4");
    expect(temperatureFinder, findsOneWidget);

    final addButton = find.byIcon(Icons.add);
    await tester.tap(addButton);

    temperatureFinder = find.text("36.5");
    expect(temperatureFinder, findsOneWidget);
  });
}
