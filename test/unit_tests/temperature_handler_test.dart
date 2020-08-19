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
