import 'package:intl/intl.dart';
import 'package:temperature_tracker/utilities/constants.dart';

class Log {
  final int id = _generateRandomId;
  DateTime dateTime = DateTime.now();
  final double temperature;

  Log(this.temperature);

  static int get _generateRandomId {
    return (((DateTime.now()).millisecondsSinceEpoch) / 1000).round();
  }

  String getDateTimeString() {
    return DateFormat(DATE_FORMAT).format(dateTime);
  }

  String temperatureString() {
    return temperature.toStringAsFixed(1);
  }
}

class LogList {
  List<dynamic> items;

  LogList() {
    items = List();
  }
}
