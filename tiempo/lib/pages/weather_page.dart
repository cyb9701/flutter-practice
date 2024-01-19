import 'package:flutter/material.dart';
import 'package:fluttertiempo/pages/loading_page.dart';
import 'package:fluttertiempo/widget/details_widget.dart';
import 'package:fluttertiempo/widget/main_weather_widget.dart';
import 'package:fluttertiempo/widget/top_bar_widget.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({@required this.weatherData, @required this.controller});

  final dynamic weatherData;
  final ScrollController controller;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String temp;
  String tempMin;
  String tempMax;
  String cityName;
  String weather;

  String description;
  String feelTemp;
  String humidity;
  String windSpeed;
  String visibility;

  void updateData(dynamic data) {
    setState(() {
      if (data == null) {
        temp = 'Error';
        tempMin = 'Error';
        tempMax = 'Error';
        feelTemp = 'Error';
        cityName = 'Error';
        weather = 'Error';
        description = 'Error';
        humidity = 'Error';
        windSpeed = 'Error';
        visibility = 'Error';
        return null;
      }

      double kelvin = data['main']['temp'];
      double kelvinMin = data['main']['temp_min'];
      double kelvinMax = data['main']['temp_max'];
      double kelvinFeel = data['main']['feels_like'];
      double visible = data['visibility'] / 1000;

      temp = (kelvin - 273.15).toInt().toString();
      tempMin = (kelvinMin - 273.15).toInt().toString();
      tempMax = (kelvinMax - 273.15).toInt().toString();
      feelTemp = (kelvinFeel - 273.15).toInt().toString();
      cityName = data['name'];
      weather = data['weather'][0]['main'];
      description = data['weather'][0]['description'].toString();
      humidity = data['main']['humidity'].toString();
      windSpeed = data['wind']['speed'].toString();
      visibility = visible.toInt().toString();
    });

    print('@@@@@@ UpdateData @@@@@@');
  }

  @override
  void initState() {
    updateData(widget.weatherData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      children: <Widget>[
        buildMainZone(),
        buildDetailsZone(),
      ],
    );
  }

  Container buildMainZone() {
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TopBarWidget(
            updateFunction: (dynamic data) {
              updateData(data);
            },
            weatherData: widget.weatherData,
            cityName: cityName,
          ),
          MainWeatherWidget(
              weather: weather, tempMin: tempMin, tempMax: tempMax, temp: temp),
        ],
      ),
    );
  }

  Container buildDetailsZone() {
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
      child: Column(
        children: <Widget>[
          DetailsWidget(
            description: description,
            feelTemp: feelTemp,
            humidity: humidity,
            windSpeed: windSpeed,
            visibility: visibility,
          ),
        ],
      ),
    );
  }
}
