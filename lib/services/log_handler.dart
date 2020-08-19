import 'package:temperature_tracker/models/log.dart';

class LogHandler {
  final _list = LogList();

  LogList get logList {
    _list.items.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return _list;
  }

  void addLog(Log log) {
    _list.items.add(log);
  }

  void removeLog(int index) {
    _list.items.removeAt(index);
  }

  double getHighestTemperature() {
    if (_list.items.isNotEmpty) {
      final tempItems = _list.items;
      tempItems.sort((a, b) => b.temperature.compareTo(a.temperature));
      return tempItems.first.temperature;
    } else {
      return 0.0;
    }
  }

  double updateTemperature(bool isIncrement, double currentTemperature) {
    if (isIncrement) {
      currentTemperature += 0.1;
    } else {
      currentTemperature -= 0.1;
    }

    return currentTemperature;
  }
}
