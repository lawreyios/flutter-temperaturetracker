import 'package:flutter/material.dart';
import 'package:temperature_tracker/services/temperature_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given temperature, it should resolve to the correct color', () async {
    final highFeverTemperatureHandler = TemperatureHandler(39.4);

    expect(highFeverTemperatureHandler.temperatureColor(),
        equals(Colors.red[700]));

    final feverTemperatureHandler = TemperatureHandler(38.4);

    expect(
        feverTemperatureHandler.temperatureColor(), equals(Colors.orange[700]));

    final lowGradeFeverTemperatureHandler = TemperatureHandler(37.4);

    expect(lowGradeFeverTemperatureHandler.temperatureColor(),
        equals(Colors.yellow[700]));

    final normalTemperatureHandler = TemperatureHandler(36.0);

    expect(
        normalTemperatureHandler.temperatureColor(), equals(Colors.green[700]));

    final coldTemperatureHandler = TemperatureHandler(35.9);

    expect(
        coldTemperatureHandler.temperatureColor(), equals(Colors.green[300]));
  });

  test('Given temperature, it should resolve to the grade', () async {
    final highFeverTemperatureHandler = TemperatureHandler(39.4);

    expect(
        highFeverTemperatureHandler.temperatureGrade(), equals("High Fever"));

    final feverTemperatureHandler = TemperatureHandler(38.4);

    expect(feverTemperatureHandler.temperatureGrade(), equals("Fever"));

    final lowGradeFeverTemperatureHandler = TemperatureHandler(37.4);

    expect(lowGradeFeverTemperatureHandler.temperatureGrade(),
        equals("Low Grade Fever"));

    final normalTemperatureHandler = TemperatureHandler(36.0);

    expect(normalTemperatureHandler.temperatureGrade(),
        equals("Normal Temperature"));

    final coldTemperatureHandler = TemperatureHandler(35.9);

    expect(
        coldTemperatureHandler.temperatureGrade(), equals("Cold Temperature"));
  });
}
