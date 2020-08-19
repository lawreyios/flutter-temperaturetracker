/*
 * Copyright (c) 2020 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

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
