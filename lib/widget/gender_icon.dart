import 'package:flutter/material.dart';

class GenderIcon extends StatelessWidget {
  GenderIcon(
      {@required this.gender,
      @required this.iconImg,
      this.iconColor,
      this.textColor,
      this.textSize,
      this.iconSize});

  final String gender;
  final IconData iconImg;
  final Color iconColor;
  final Color textColor;
  final double textSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconImg,
          size: iconSize,
          color: iconColor,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          gender,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          ),
        ),
      ],
    );
  }
}
