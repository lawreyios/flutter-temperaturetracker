import 'package:flutter/material.dart';

class TemperatureHandler {
  final double temperature;

  TemperatureHandler(this.temperature);

  Color temperatureColor() {
    if (temperature >= 39.4) {
      return Colors.red[700];
    } else if (temperature >= 38.4 && temperature <= 39.3) {
      return Colors.orange[700];
    } else if (temperature >= 37.4 && temperature <= 38.3) {
      return Colors.yellow[700];
    } else if (temperature >= 36.0 && temperature <= 37.3) {
      return Colors.green[700];
    } else {
      return Colors.green[300];
    }
  }

  String temperatureGrade() {
    if (temperature >= 39.4) {
      return "High Fever";
    } else if (temperature >= 38.4 && temperature <= 39.3) {
      return "Fever";
    } else if (temperature >= 37.4 && temperature <= 38.3) {
      return "Low Grade Fever";
    } else if (temperature >= 36.0 && temperature <= 37.3) {
      return "Normal Temperature";
    } else {
      return "Cold Temperature";
    }
  }
}
