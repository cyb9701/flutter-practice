import 'package:flutter/material.dart';
import 'package:flutterbmicalculator/constants/constants.dart';

class BottomButton extends StatelessWidget {
  BottomButton({@required this.name, @required this.onTap});

  final String name;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kkBottomBtnColor,
        margin: EdgeInsets.only(top: 30),
        width: double.infinity,
        height: 80,
        padding: EdgeInsets.only(bottom: 20),
        child: Center(
            child: Text(
          name,
          style: kkLabelTextStyle,
        )),
      ),
    );
  }
}
