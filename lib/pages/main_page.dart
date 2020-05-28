import 'package:flutter/material.dart';
import 'package:fluttertiempo/pages/weather_page.dart';
import 'package:fluttertiempo/provider/pos.dart';
import 'package:provider/provider.dart';

final List<Widget> _weatherPages = [];
final List<Pos> _posList = [];
Size size;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;

  //get position data and set position.
  void _onScroll() {
    double pagePos = _pageController.page;
    _posList[pagePos.truncate().toInt()].setPosition(pagePos);
  }

  @override
  void initState() {
    _pageController = PageController()..addListener(_onScroll);

    //add position data to list and add weather pages.
    for (int i = 0; i < 4; i++) {
      var newPos = Pos(i);
      _posList.add(newPos);
      _weatherPages.add(
        ChangeNotifierProvider.value(
          value: newPos,
          child: WeatherPage(),
        ),
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (size == null) size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _weatherPages,
      ),
    );
  }
}
