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

  void _onScroll() {
    widget._sigma.setSigma(_scrollController.offset / size.height * blur);
  }

  @override
  void initState() {
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
    return SafeArea(
      child: Stack(
        children: <Widget>[
          ChangeNotifierProvider.value(
            value: widget._sigma,
            child: WeatherBackground(),
          ),
        ],
      ),
    );
  }
}
