import 'package:flutter/material.dart';
import 'package:fluttertiempo/pages/main_page.dart';
import 'package:fluttertiempo/service/weather_data.dart';

Size size;

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  void getWeatherData() async {
    dynamic weatherData = await WeatherData().curWeatherData();

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage(weatherData: weatherData)),
        (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.greenAccent,
        ),
      ),
    );
  }
}
