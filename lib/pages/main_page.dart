import 'package:flutter/material.dart';
import 'package:fluttertiempo/components/temp_min_max.dart';
import 'package:fluttertiempo/components/weather_background.dart';
import 'package:fluttertiempo/pages/loading_page.dart';
import 'package:fluttertiempo/provider/sigma.dart';
import 'package:provider/provider.dart';

final double blur = 8;

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
  String cityName;

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
        cityName = 'Error';
        return null;
      }

      double fahrenheit = data['main']['temp'];
      double fahrenheitMin = data['main']['temp_min'];
      double fahrenheitMax = data['main']['temp_max'];

      temp = (fahrenheit - 273.15).toInt().toString();
      tempMin = (fahrenheitMin - 273.15).toInt().toString();
      tempMax = (fahrenheitMax - 273.15).toInt().toString();
      cityName = data['name'];
      print('@@@@@@@@@@@@@@@@ $cityName');
    });
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
                    ListTile(
                      leading: Icon(Icons.near_me),
                      title: Text(
                        cityName,
                        textScaleFactor: 2,
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 1.0),
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
                        Text(
                          '$temp°',
                          textScaleFactor: 10,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}
