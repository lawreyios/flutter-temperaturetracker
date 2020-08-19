import 'package:temperature_tracker/models/log.dart';

class MockDataProvider {
  LogList getMockLogList() {
    final _list = LogList();
    final newLog1 = Log(36.5);
    newLog1.dateTime = DateTime(2020, 10, 1, 10, 0, 1, 0, 0);
    final newLog2 = Log(36.6);
    newLog2.dateTime = DateTime(2020, 10, 1, 10, 1, 1, 0, 0);
    final newLog3 = Log(36.7);
    newLog3.dateTime = DateTime(2020, 10, 1, 10, 2, 1, 0, 0);
    final newLog4 = Log(36.8);
    newLog4.dateTime = DateTime(2020, 10, 1, 10, 3, 1, 0, 0);
    _list.items.addAll([newLog1, newLog2, newLog3, newLog4]);
    return _list;
  }
}
