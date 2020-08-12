import 'package:flutter_test/flutter_test.dart';
import 'package:temperature_tracker/models/log.dart';
import 'package:temperature_tracker/utilities/dependency_injector.dart';
import 'package:temperature_tracker/utilities/log_handler.dart';

import '../data/mock_data_provider.dart';

void main() {
  setupDependencies();

  LogHandler logHandler = getIt<LogHandler>();

  LogList mockLogList = MockDataProvider().getMockLogList();

  mockLogList.items.forEach((log) {
    logHandler.addLog(log);
  });

  LogList sortedLogList = logHandler.logList;

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
    Log newLog = Log(40.0);
    newLog.dateTime = new DateTime(2020, 10, 1, 10, 4, 1, 0, 0);
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
    double highestTemperature = logHandler.getHighestTemperature();

    expect(highestTemperature, equals(36.8));
  });

  test(
      'Given a Log Editor, it should be able to increment or decrement temperature by 0.1',
      () async {
    double baseTemperature = 36.5;

    expect(logHandler.updateTemperature(true, baseTemperature), equals(36.6));
    expect(logHandler.updateTemperature(false, baseTemperature), equals(36.4));
  });
}
