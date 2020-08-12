import 'package:intl/intl.dart';

class Log {
  final int id = (((DateTime.now()).millisecondsSinceEpoch) / 1000).round();
  DateTime dateTime = DateTime.now();
  final double temperature;

  Log(this.temperature);

  String getDateTimeString() {
    return DateFormat('hh:mm a').format(dateTime);
  }

  String temperatureString() {
    return temperature.toStringAsFixed(1);
  }
}

class LogList {
  List<dynamic> items;

  LogList() {
    items = new List();
  }
}
