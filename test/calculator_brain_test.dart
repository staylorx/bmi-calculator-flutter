import 'package:bmi_calculator/calculator_brain.dart';
import 'package:flutter_test/flutter_test.dart';
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

const Map testData = {
  1: {
    'height': 77,
    'weight': 250,
    'measuredIn': MeasuredIn.Imperial,
    'result': 'overweight',
    "bmi": "29.6"
  },
  2: {
    'height': 77,
    'weight': 268,
    'measuredIn': MeasuredIn.Imperial,
    'result': 'obese',
    "bmi": "31.8"
  },
  3: {
    'height': 180,
    'weight': 63,
    'measuredIn': MeasuredIn.Metric,
    'result': 'normal',
    "bmi": "19.4"
  },
  4: {
    'height': 154,
    'weight': 70,
    'measuredIn': MeasuredIn.Metric,
    'result': 'overweight',
    "bmi": "29.5"
  }
};

void main() {
  Logger.level = Level.debug;
  testWidgets('calculator brain ...', (tester) async {
    for (var k in testData.keys) {
      Map v = testData[k];
      logger.i("Running test $k");
      CalculatorBrain calcBrain = CalculatorBrain(
        v['height'],
        v['weight'],
        v['measuredIn'],
      );
      assert(calcBrain.getResult() == v['result']);
      assert(calcBrain.getBMI() == v["bmi"]);
    }
  });
}
