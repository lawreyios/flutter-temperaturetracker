import 'package:temperature_tracker/models/log.dart';

class MockDataProvider {
  LogList getMockLogList() {
    LogList _list = LogList();
    Log newLog1 = Log(36.5);
    newLog1.dateTime = new DateTime(2020, 10, 1, 10, 0, 1, 0, 0);
    Log newLog2 = Log(36.6);
    newLog2.dateTime = new DateTime(2020, 10, 2, 10, 0, 1, 0, 0);
    Log newLog3 = Log(36.7);
    newLog3.dateTime = new DateTime(2020, 10, 3, 10, 0, 1, 0, 0);
    Log newLog4 = Log(36.8);
    newLog4.dateTime = new DateTime(2020, 10, 4, 10, 0, 1, 0, 0);
    _list.items.addAll([newLog1, newLog2, newLog3, newLog4]);
    return _list;
  }
}
