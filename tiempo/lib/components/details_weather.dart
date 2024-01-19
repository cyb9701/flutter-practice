import 'package:flutter/material.dart';
import 'package:fluttertiempo/constants/constants.dart';

class DetailsWeather extends StatelessWidget {
  DetailsWeather({@required this.name, @required this.weather});

  final String name;
  final String weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              name,
              style: kDetailStyle.copyWith(fontSize: 18.0),
            ),
            Text(
              weather,
              style: kDetailStyle.copyWith(fontSize: 18.0),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.3,
        ),
      ],
    );
  }
}
