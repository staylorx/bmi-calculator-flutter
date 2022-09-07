import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final String bmiResult;
  final String resultText;

  const ResultsPage({
    Key? key,
    required this.bmiResult,
    required this.resultText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI Calculator"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.bottomLeft,
              child: const Text(
                "Your Result",
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: ReusableCard(
              colour: kActiveCardColor,
              cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(resultText, style: kResultsTextStyle),
                    Text(bmiResult, style: kBMITextStyle),
                    // Text(
                    //   'Perfectly OK',
                    //   style: kBodyTextStyle,
                    //   textAlign: TextAlign.center,
                    // ),
                  ]),
              onPress: () {},
            ),
          ),
          BottomButton(
              title: "RE-CALCULATE",
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
