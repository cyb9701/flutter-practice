import 'package:flutter/material.dart';
import 'package:fluttertiempo/components/temp_min_max.dart';

class MainWeatherWidget extends StatefulWidget {
  MainWeatherWidget({
    @required this.weather,
    @required this.tempMin,
    @required this.tempMax,
    @required this.temp,
  });

  final String weather;
  final String tempMin;
  final String tempMax;
  final String temp;

  @override
  _MainWeatherWidgetState createState() => _MainWeatherWidgetState();
}

class _MainWeatherWidgetState extends State<MainWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildWeather(),
        SizedBox(height: 20.0),
        Row(
          children: <Widget>[
            buildMaxTemp(),
            SizedBox(width: 20.0),
            buildMinTemp(),
          ],
        ),
        buildMainTemp(),
      ],
    );
  }

  Text buildWeather() {
    return Text(
      widget.weather,
      textScaleFactor: 2,
      style: TextStyle(fontWeight: FontWeight.w200),
    );
  }

  TempMinMax buildMaxTemp() {
    return TempMinMax(
      icon: Icons.keyboard_arrow_down,
      temp: widget.tempMin,
      color: Colors.blueAccent,
    );
  }

  TempMinMax buildMinTemp() {
    return TempMinMax(
      icon: Icons.keyboard_arrow_up,
      temp: widget.tempMax,
      color: Colors.redAccent,
    );
  }

  Text buildMainTemp() {
    return Text(
      '${widget.temp}°',
      textScaleFactor: 8,
      style: TextStyle(fontWeight: FontWeight.w200),
    );
  }
}
