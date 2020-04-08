import 'package:flutter/material.dart';
import 'package:flutterbmicalculator/constants/constants.dart';

class RoundIconBtn extends StatelessWidget {
  RoundIconBtn({
    @required this.icon,
    @required this.onPress,
  });

  final IconData icon;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPress,
      elevation: 10.0,
      constraints: BoxConstraints.tightFor(
        width: 50,
        height: 50,
      ),
      fillColor: kkInActiveGenderColor,
      shape: CircleBorder(),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
