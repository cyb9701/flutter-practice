import 'package:flutter/material.dart';
import 'package:fluttertiempo/components/temp_min_max.dart';
import 'package:fluttertiempo/components/weather_background.dart';
import 'package:fluttertiempo/pages/loading_page.dart';
import 'package:fluttertiempo/provider/sigma.dart';
import 'package:fluttertiempo/service/weather_data.dart';
import 'package:provider/provider.dart';

final double blur = 10;

class MainPage extends StatefulWidget {
  MainPage({@required this.weatherData});

  final dynamic weatherData;
  final Sigma _sigma = new Sigma();

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  ScrollController _scrollController;
  String temp;
  String tempMin;
  String tempMax;
  String feelTemp;
  String cityName;
  String weather;

  //control blur value.
  void _onScroll() {
    widget._sigma.setSigma(_scrollController.offset / size.height * blur);
  }

  void updateData(dynamic data) {
    setState(() {
      if (data == null) {
        temp = 'Error';
        tempMin = 'Error';
        tempMax = 'Error';
        feelTemp = 'Error';
        cityName = 'Error';
        weather = 'Error';
        return null;
      }

      double kelvin = data['main']['temp'];
      double kelvinMin = data['main']['temp_min'];
      double kelvinMax = data['main']['temp_max'];
      double kelvinFeel = data['main']['feels_like'];

      temp = (kelvin - 273.15).toInt().toString();
      tempMin = (kelvinMin - 273.15).toInt().toString();
      tempMax = (kelvinMax - 273.15).toInt().toString();
      feelTemp = (kelvinFeel - 273.15).toInt().toString();
      cityName = data['name'];
      weather = data['weather'][0]['main'];
    });

    print('@@@@@@ UpdateData @@@@@@');
  }

  @override
  void initState() {
    //listen changed blur value.
    _scrollController = ScrollController()..addListener(_onScroll);
    updateData(widget.weatherData);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ChangeNotifierProvider.value(
            value: widget._sigma,
            child: WeatherBackground(),
          ),
          ListView(
            controller: _scrollController,
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                        Spacer(flex: 4),
                        Icon(Icons.near_me),
                        Spacer(flex: 1),
                        Text(
                          cityName,
                          textScaleFactor: 2,
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                        Spacer(flex: 4),
                        IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () async {
                              var getData =
                                  await WeatherData().curWeatherData();
                              updateData(getData);
                            }),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '$temp°',
                              textScaleFactor: 10,
                              style: TextStyle(fontWeight: FontWeight.w200),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                weather,
                                textScaleFactor: 3,
                                style: TextStyle(fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                child: Text(feelTemp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
