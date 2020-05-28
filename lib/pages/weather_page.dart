import 'package:flutter/material.dart';
import 'package:fluttertiempo/components/weather_background.dart';
import 'package:fluttertiempo/pages/main_page.dart';
import 'package:fluttertiempo/provider/sigma.dart';
import 'package:provider/provider.dart';

final double blur = 8;

class WeatherPage extends StatefulWidget {
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
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  '21°',
                  textScaleFactor: 9,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
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
