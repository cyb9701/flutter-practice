import 'dart:convert';

import 'package:http/http.dart';

class WeatherAPI {
  static const String _api = '59058a87772346d9bc1918ac63e319e4';
  final String _url =
      'http://api.openweathermap.org/data/2.5/weather?lat=37.4219983&lon=-122.084&appid=$_api';

  Future<dynamic> getWeatherData() async {
    Response response = await get(_url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('@@@@@@ ErrorCode: ${response.statusCode} @@@@@@');
    }
  }
}
