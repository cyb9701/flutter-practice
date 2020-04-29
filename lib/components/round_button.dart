import 'package:flutter/material.dart';
import 'package:flutteridmemo/constants/constants.dart';

class RoundButton extends StatelessWidget {
  RoundButton({
    @required this.title,
    @required this.onPressed,
    @required this.color,
  });

  final String title;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(kRadiusValue20),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}
