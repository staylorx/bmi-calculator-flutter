// ignore_for_file: constant_identifier_names, non_constant_identifier_names, prefer_initializing_formals

import 'dart:math';
import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: false,
    printTime: false,
  ),
);

enum MeasuredIn { Metric, Imperial }

class CalculatorBrain {
  late int height; //cm or inches
  late int weight; //kilos or pounds
  late MeasuredIn measuredIn;

  late double _height; //meters
  late double _weight; //kilos
  late double _bmi;

  CalculatorBrain(int height, int weight, MeasuredIn measuredIn) {
    this.height = height;
    this.weight = weight;
    this.measuredIn = measuredIn;
    logger.d(
        "Constructor: height $height, weight $weight, measuredIn $measuredIn");
    calculateBMI();
  }

  calculateBMI() {
    //converts to metric: meters and kilos
    if (measuredIn == MeasuredIn.Imperial) {
      //convert inches to cm
      _height = height / 39.3700787;
      _weight = weight * 0.4536;
    } else {
      _height = height / 100.0;
      _weight = weight.toDouble();
    }
    measuredIn = MeasuredIn.Metric;

    _bmi = _weight / pow(_height, 2);
  }

  String getBMI() {
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    String category = '';

    if (_bmi <= 18.5) {
      category = "underweight";
    } else if (_bmi <= 24.9) {
      category = "normal";
    } else if (_bmi <= 29.9) {
      category = "overweight";
    } else {
      category = "obese";
    }

    return category;
  }
}
