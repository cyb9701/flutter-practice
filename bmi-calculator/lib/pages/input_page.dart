import 'package:flutter/material.dart';
import 'package:flutterbmicalculator/constants/constants.dart';
import 'package:flutterbmicalculator/pages/result_page.dart';
import 'package:flutterbmicalculator/widget/bmi_calculator.dart';
import 'package:flutterbmicalculator/widget/bottom_button.dart';
import 'package:flutterbmicalculator/widget/gender_icon.dart';
import 'package:flutterbmicalculator/widget/reusable_card.dart';
import 'package:flutterbmicalculator/widget/round_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/*
enum Gender{
  male,
  female,
}
*/

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  bool _clickedMale = false;
  bool _clickedFemale = false;

  int height = 0;
  int weight = 50;
  int age = 0;

  //Gender selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReUsableCard(
                    onPress: () {
                      setState(() {
                        _clickedMale = true;
                        _clickedFemale = false;
                        //selectedGender = Gender.male;
                      });
                    },
                    color:
                        _clickedMale ? kkActiveCardColor : kkInActiveCardColor,
                    childCard: GenderIcon(
                      gender: 'MALE',
                      iconImg: FontAwesomeIcons.mars,
                      iconColor: _clickedMale
                          ? kkActiveGenderColor
                          : kkInActiveGenderColor,
                      textColor: _clickedMale
                          ? kkActiveGenderColor
                          : kkInActiveGenderColor,
                      textSize: _clickedMale ? kkLabelTextSize : 18,
                      iconSize: _clickedMale ? 90 : 80,
                    ),
                  ),
                ),
                Expanded(
                  child: ReUsableCard(
                    onPress: () {
                      setState(() {
                        _clickedMale = false;
                        _clickedFemale = true;
                        //selectedGender = Gender.male;
                      });
                    },
                    color: _clickedFemale
                        ? kkActiveCardColor
                        : kkInActiveCardColor,
                    childCard: GenderIcon(
                      gender: 'FEMALE',
                      iconImg: FontAwesomeIcons.venus,
                      iconColor: _clickedFemale
                          ? kkActiveGenderColor
                          : kkInActiveGenderColor,
                      textColor: _clickedFemale
                          ? kkActiveGenderColor
                          : kkInActiveGenderColor,
                      textSize: _clickedFemale ? kkLabelTextSize : 18,
                      iconSize: _clickedFemale ? 90 : 80,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ReUsableCard(
              color: kkActiveCardColor,
              childCard: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kkLabelTextStyle,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: height.toString(),
                          style: kkNumTextStyle,
                        ),
                        TextSpan(text: '    '),
                        TextSpan(
                          text: 'cm',
                          style: kkLabelTextStyle,
                        ),
                      ],
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.white,
                      inactiveTrackColor: kkInActiveGenderColor,
                      thumbColor: kkBottomBtnColor,
                      overlayColor: Color(0x40EA1656),
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 13),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 23),
                    ),
                    child: Slider(
                      value: height.toDouble(),
                      min: 0,
                      max: 300,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.round();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ReUsableCard(
                    color: kkActiveCardColor,
                    childCard: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kkLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kkNumTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconBtn(
                              icon: Icons.remove,
                              onPress: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundIconBtn(
                              icon: Icons.add,
                              onPress: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ReUsableCard(
                    color: kkActiveCardColor,
                    childCard: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kkLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kkNumTextStyle,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            RoundIconBtn(
                              icon: Icons.remove,
                              onPress: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RoundIconBtn(
                              icon: Icons.add,
                              onPress: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          BottomButton(
              name: 'CALCULATOR',
              onTap: () {
                BMICalculator cal =
                    BMICalculator(height: height, weight: weight);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultPage(
                      bmiResult: cal.bmi(),
                      resultText: cal.getResult(),
                      interpretation: cal.getInterpretation(),
                    ),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
