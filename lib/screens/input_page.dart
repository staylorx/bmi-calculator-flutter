// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, constant_identifier_names

import 'package:bmi_calculator/calculator_brain.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/screens/results_page.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

enum Gender {
  NONE, //only use once
  MALE,
  FEMALE,
}

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  InputPageState createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  Gender selectedGender = Gender.NONE;
  int userHeight = 66;
  int userWeight = 150;
  int userAge = 34;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(children: [
              Expanded(
                child: ReusableCard(
                  colour: selectedGender == Gender.MALE
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.mars,
                    label: "MALE",
                  ),
                  onPress: () {
                    logger.d("MALE card tapped");
                    setState(() {
                      selectedGender = Gender.MALE;
                    });
                  },
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: selectedGender == Gender.FEMALE
                      ? kActiveCardColor
                      : kInactiveCardColor,
                  cardChild: IconContent(
                    icon: FontAwesomeIcons.venus,
                    label: "FEMALE",
                  ),
                  onPress: () {
                    logger.d("FEMALE card tapped");
                    setState(() {
                      selectedGender = Gender.FEMALE;
                    });
                  },
                ),
              )
            ]),
          ),
          Expanded(
            child: ReusableCard(
              colour: kActiveCardColor,
              cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('HEIGHT', style: kLabelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(userHeight.toString(), style: kNumberTextStyle),
                        Text('in', style: kLabelTextStyle),
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Color(0xFF8D8E98),
                        thumbColor: Color(0xFFEB1555),
                        overlayColor: Color(0x29EB1555),
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                            RoundSliderOverlayShape(overlayRadius: 30.0),
                      ),
                      child: Slider(
                        value: userHeight.toDouble(),
                        min: kMinHeight.toDouble(),
                        max: kMaxHeight.toDouble(),
                        onChanged: (double newValue) {
                          setState(() {
                            userHeight = newValue.toInt();
                          });
                        },
                      ),
                    )
                  ]),
              onPress: () {},
            ),
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('WEIGHT', style: kLabelTextStyle),
                        Text(userWeight.toString(), style: kNumberTextStyle),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      userWeight--;
                                    });
                                  }),
                              SizedBox(width: 10.0),
                              RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      userWeight++;
                                    });
                                  }),
                            ]),
                      ]),
                  onPress: () {},
                ),
              ),
              Expanded(
                child: ReusableCard(
                  colour: kActiveCardColor,
                  cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('AGE', style: kLabelTextStyle),
                        Text(userAge.toString(), style: kNumberTextStyle),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RoundIconButton(
                                  icon: FontAwesomeIcons.minus,
                                  onPressed: () {
                                    setState(() {
                                      userAge--;
                                    });
                                  }),
                              SizedBox(width: 10.0),
                              RoundIconButton(
                                  icon: FontAwesomeIcons.plus,
                                  onPressed: () {
                                    setState(() {
                                      userAge++;
                                    });
                                  }),
                            ]),
                      ]),
                  onPress: () {},
                ),
              ),
            ]),
          ),
          BottomButton(
              title: "CALCULATE",
              onTap: () {
                CalculatorBrain calcBrain = CalculatorBrain(
                  userHeight,
                  userWeight,
                  MeasuredIn.Imperial,
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      bmiResult: calcBrain.getBMI(),
                      resultText: calcBrain.getResult(),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
