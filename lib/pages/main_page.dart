import 'package:flutter/material.dart';
import 'package:fluttertiempo/components/weather_background.dart';
import 'package:fluttertiempo/pages/loading_page.dart';
import 'package:fluttertiempo/pages/weather_page.dart';
import 'package:fluttertiempo/provider/sigma.dart';
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

  //control blur value.
  void _onScroll() {
    widget._sigma.setSigma((_scrollController.offset / size.height) * blur);
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
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ChangeNotifierProvider.value(
            value: widget._sigma,
            child: WeatherBackground(),
          ),
          WeatherPage(
            weatherData: widget.weatherData,
            controller: _scrollController,
          ),
        ],
      ),
    );
  }
}
