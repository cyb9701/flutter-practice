import 'package:flutter/material.dart';
import 'package:fluttertiempo/components/details_weather.dart';
import 'package:fluttertiempo/constants/constants.dart';

class DetailsWidget extends StatefulWidget {
  DetailsWidget({
    @required this.description,
    @required this.feelTemp,
    @required this.humidity,
    @required this.windSpeed,
    @required this.visibility,
  });

  final String description;
  final String feelTemp;
  final String humidity;
  final String windSpeed;
  final String visibility;

  @override
  _DetailsWidgetState createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.black45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Details',
            style: kDetailStyle,
          ),
          Divider(
            color: Colors.white,
            thickness: 0.5,
            height: 30.0,
          ),
          DetailsWeather(name: 'Description', weather: widget.description),
          DetailsWeather(
              name: 'sensible temperature', weather: '${widget.feelTemp}°'),
          DetailsWeather(name: 'Humidity', weather: '${widget.humidity}%'),
          DetailsWeather(
              name: 'Wind Speed', weather: '${widget.windSpeed}km/s'),
          DetailsWeather(name: 'Visibility', weather: '${widget.visibility}km'),
        ],
      ),
    );
  }
}
