import 'package:flutter/material.dart';
import 'package:temperature_tracker/utilities/temperature_handler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given temperature, it should resolve to the correct color', () async {
    TemperatureHandler highFeverTemperatureHandler = TemperatureHandler(39.4);

    expect(highFeverTemperatureHandler.temperatureColor(),
        equals(Colors.red[700]));

    TemperatureHandler feverTemperatureHandler = TemperatureHandler(38.4);

    expect(
        feverTemperatureHandler.temperatureColor(), equals(Colors.orange[700]));

    TemperatureHandler lowGradeFeverTemperatureHandler =
        TemperatureHandler(37.4);

    expect(lowGradeFeverTemperatureHandler.temperatureColor(),
        equals(Colors.yellow[700]));

    TemperatureHandler normalTemperatureHandler = TemperatureHandler(36.0);

    expect(
        normalTemperatureHandler.temperatureColor(), equals(Colors.green[700]));

    TemperatureHandler coldTemperatureHandler = TemperatureHandler(35.9);

    expect(
        coldTemperatureHandler.temperatureColor(), equals(Colors.green[300]));
  });

  test('Given temperature, it should resolve to the grade', () async {
    TemperatureHandler highFeverTemperatureHandler = TemperatureHandler(39.4);

    expect(
        highFeverTemperatureHandler.temperatureGrade(), equals("High Fever"));

    TemperatureHandler feverTemperatureHandler = TemperatureHandler(38.4);

    expect(feverTemperatureHandler.temperatureGrade(), equals("Fever"));

    TemperatureHandler lowGradeFeverTemperatureHandler =
        TemperatureHandler(37.4);

    expect(lowGradeFeverTemperatureHandler.temperatureGrade(),
        equals("Low Grade Fever"));

    TemperatureHandler normalTemperatureHandler = TemperatureHandler(36.0);

    expect(normalTemperatureHandler.temperatureGrade(),
        equals("Normal Temperature"));

    TemperatureHandler coldTemperatureHandler = TemperatureHandler(35.9);

    expect(
        coldTemperatureHandler.temperatureGrade(), equals("Cold Temperature"));
  });
}
