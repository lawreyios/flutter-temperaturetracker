import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_tracker/home.dart';
import 'package:temperature_tracker/models/log.dart';
import 'package:temperature_tracker/utilities/constants.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';
import 'package:temperature_tracker/utilities/log_handler.dart';
import 'package:temperature_tracker/utilities/temperature_handler.dart';
import '../data/mock_data_provider.dart';

void main() {
  setupDependencies();

  LogHandler logHandler = getIt<LogHandler>();

  testWidgets(
      'Given user enters home page for the first time, there should not be any logs shown',
      (WidgetTester tester) async {
    await tester.pumpWidget(HomePageWrapper());

    final logListKey = find.byKey(Key(LOG_LIST_KEY));
    expect(logListKey, findsOneWidget);

    WidgetPredicate widgetAddLogButton =
        (Widget widget) => widget is FloatingActionButton;

    expect(find.byWidgetPredicate(widgetAddLogButton), findsOneWidget);

    WidgetPredicate widgetAppBar = (Widget widget) => widget is AppBar;

    expect(find.byWidgetPredicate(widgetAppBar), findsOneWidget);

    final titleFinder = find.text(HOME_PAGE_TITLE);
    expect(titleFinder, findsOneWidget);
  });

  testWidgets('Given user has recorded some logs, there should logs shown',
      (WidgetTester tester) async {
    LogList mockLogList = MockDataProvider().getMockLogList();

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
  for (var log in logList.items) {
    final temperatureReading = find.text("${log.temperatureString()}°C");
    final logTime = find.text("${log.getDateTimeString()}");
    await tester.ensureVisible(temperatureReading);
    expect(temperatureReading, findsOneWidget);
    await tester.ensureVisible(logTime);
    expect(logTime, findsOneWidget);

    TemperatureHandler handler = TemperatureHandler(log.temperature);
    expect(
        ((tester.firstWidget(find.text("${log.temperatureString()}°C")) as Text)
                .style)
            .color,
        handler.temperatureColor());
  }
}
