import 'package:flutter/material.dart';

class TempMinMax extends StatelessWidget {
  TempMinMax({@required this.icon, @required this.temp, @required this.color});

  final IconData icon;
  final String temp;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: color,
        ),
        SizedBox(width: 10.0),
        Text(
          '$temp°',
          textScaleFactor: 2,
        ),
      ],
    );
  }
}
