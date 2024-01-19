import 'package:flutter/material.dart';
import 'package:fluttertiempo/pages/search_page.dart';
import 'package:fluttertiempo/service/weather_data.dart';

class TopBarWidget extends StatefulWidget {
  TopBarWidget({
    @required this.weatherData,
    @required this.updateFunction,
    @required this.cityName,
  });

  final Function updateFunction;
  final dynamic weatherData;
  final String cityName;

  @override
  _TopBarWidgetState createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  dynamic _data;

  @override
  void initState() {
    setState(() {
      _data = widget.weatherData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildRefreshBtn(context),
        Spacer(flex: 4),
        buildCurrentLoctionBtn(),
        Spacer(flex: 1),
        buildCityName(),
        Spacer(flex: 4),
        buildSearchCityBtn(context),
      ],
    );
  }

  Text buildCityName() {
    return Text(
      widget.cityName,
      textScaleFactor: 2,
      style: TextStyle(fontWeight: FontWeight.w300),
    );
  }

  IconButton buildCurrentLoctionBtn() {
    return IconButton(
      icon: Icon(Icons.near_me),
      onPressed: () {
        _data = widget.weatherData;
        widget.updateFunction(_data);
      },
    );
  }

  IconButton buildRefreshBtn(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () {
        widget.updateFunction(_data);
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              '${widget.cityName} Weather Update Completed',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  Widget buildSearchCityBtn(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.location_city),
      onPressed: () async {
        var city = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SearchPage(),
            ),
          ),
        );

        print('@@@@@@ CityName:$city @@@@@@');

        if (city != null && city != '') {
          _data = await WeatherData().cityWeatherData(city);
          widget.updateFunction(_data);
        } else {
          widget.updateFunction(widget.weatherData);
        }
      },
    );
  }
}
