import 'package:flutter/material.dart';
import 'package:fluttertiempo/components/details_weather.dart';
import 'package:fluttertiempo/components/temp_min_max.dart';
import 'package:fluttertiempo/constants/constants.dart';
import 'package:fluttertiempo/pages/loading_page.dart';
import 'package:fluttertiempo/pages/search_page.dart';
import 'package:fluttertiempo/service/weather_data.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({@required this.weatherData, @required this.controller});

  final dynamic weatherData;
  final ScrollController controller;

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  dynamic _data;
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
    setState(() {
      _data = widget.weatherData;
    });
    print('@@@@@@ 1:$description @@@@@@');
    print('@@@@@@ 2:$feelTemp @@@@@@');
    print('@@@@@@ 3:$humidity @@@@@@');
    print('@@@@@@ 4:$windSpeed @@@@@@');
    print('@@@@@@ 5:$visibility @@@@@@');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        updateData(_data);
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              'Update Completed',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }),
                  Spacer(flex: 4),
                  IconButton(
                      icon: Icon(Icons.near_me),
                      onPressed: () {
                        _data = widget.weatherData;
                        updateData(_data);
                      }),
                  Spacer(flex: 1),
                  Text(
                    cityName,
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Spacer(flex: 4),
                  IconButton(
                    icon: Icon(Icons.location_city),
                    onPressed: () async {
                      var city = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: SearchPage(),
                          ),
                        ),
                      );

                      print('@@@@@@ CityName:$city @@@@@@');

                      if (city != null && city != '') {
                        _data = await WeatherData().cityWeatherData(city);
                        updateData(_data);
                      } else {
                        updateData(widget.weatherData);
                      }
                    },
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    weather,
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      TempMinMax(
                        icon: Icons.keyboard_arrow_down,
                        temp: tempMin,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 20.0),
                      TempMinMax(
                        icon: Icons.keyboard_arrow_up,
                        temp: tempMax,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                  Text(
                    '$temp°',
                    textScaleFactor: 8,
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 70.0),
          child: Column(
            children: <Widget>[
              Container(
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
                    DetailsWeather(
                        name: 'Description', weather: '$description'),
                    DetailsWeather(
                        name: 'sensible temperature', weather: '$feelTemp°'),
                    DetailsWeather(name: 'Humidity', weather: '$humidity%'),
                    DetailsWeather(
                        name: 'Wind Speed', weather: '${windSpeed}km/s'),
                    DetailsWeather(
                        name: 'Visibility', weather: '${visibility}km'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
