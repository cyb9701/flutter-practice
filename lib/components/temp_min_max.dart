import 'package:flutter/material.dart';

class TempMinMax extends StatelessWidget {
  TempMinMax({@required this.icon, @required this.temp});

  final IconData icon;
  final String temp;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
        ),
        SizedBox(width: 10.0),
        Text(
          '$temp°',
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}
