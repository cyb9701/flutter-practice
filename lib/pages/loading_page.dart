import 'package:flutter/material.dart';
import 'package:fluttertiempo/pages/main_page.dart';
import 'package:fluttertiempo/service/weather_data.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void getWeatherData() async {
    dynamic dataBody = await WeatherData().curWeatherData();

    double fahrenheit = dataBody['main']['temp'];
    double fahrenheitMin = dataBody['main']['temp_min'];
    double fahrenheitMax = dataBody['main']['temp_max'];
    dynamic temp = (fahrenheit - 273.15).toInt().toString();
    dynamic tempMin = (fahrenheitMin - 273.15).toInt().toString();
    dynamic tempMax = (fahrenheitMax - 273.15).toInt().toString();
    print('@@@@@ $temp');
    print('@@@@@ $tempMin');
    print('@@@@@ $tempMax');

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MainPage(temp: temp, tempMin: tempMin, tempMax: tempMax)));
  }

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }
}
