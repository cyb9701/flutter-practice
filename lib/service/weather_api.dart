import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class WeatherAPI {
  WeatherAPI({@required this.url});

  final String url;

  Future<dynamic> getWeatherData() async {
    Response response = await get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('@@@@@@ ErrorCode: ${response.statusCode} @@@@@@');
    }
  }
}
