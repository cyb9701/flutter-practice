import 'package:flutter/material.dart';
import 'package:fluttertiempo/components/temp_min_max.dart';
import 'package:fluttertiempo/components/weather_background.dart';
import 'package:fluttertiempo/pages/main_page.dart';
import 'package:fluttertiempo/provider/sigma.dart';
import 'package:provider/provider.dart';

final double blur = 8;

class WeatherPage extends StatefulWidget {
  WeatherPage(
      {@required this.temp, @required this.tempMin, @required this.tempMax});

  final String temp;
  final String tempMin;
  final String tempMax;
  final Sigma _sigma = new Sigma();

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  ScrollController _scrollController;

  //control blur value.
  void _onScroll() {
    widget._sigma.setSigma(_scrollController.offset / size.height * blur);
  }

  @override
  void initState() {
    //listen changed blur value.
    _scrollController = ScrollController()..addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      TempMinMax(
                          icon: Icons.keyboard_arrow_down,
                          temp: widget.tempMin),
                      SizedBox(width: 20.0),
                      TempMinMax(
                          icon: Icons.keyboard_arrow_up, temp: widget.tempMax),
                    ],
                  ),
                  Text(
                    '${widget.temp}°',
                    textScaleFactor: 9,
                    style: TextStyle(fontWeight: FontWeight.w200),
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
    );
  }
}
