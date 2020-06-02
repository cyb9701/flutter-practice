import 'package:fluttertiempo/service/location.dart';
import 'package:fluttertiempo/service/weather_api.dart';

class WeatherData {
  static String _api = '59058a87772346d9bc1918ac63e319e4';

  Future<dynamic> curWeatherData() async {
    Location _location = Location();
    await _location.getCurrentLocation();

    WeatherAPI _weatherAPI = WeatherAPI(
        url:
            'http://api.openweathermap.org/data/2.5/weather?lat=${_location.lat}&lon=${_location.lon}&appid=$_api');
    var weatherData = await _weatherAPI.getWeatherData();
    print('@@@@@@ WeatherData: $weatherData @@@@@@');
    return weatherData;
  }

  Future<dynamic> cityWeatherData(String city) async {
    WeatherAPI _weatherAPI = WeatherAPI(
        url:
            'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_api');
    var cityWeatherData = await _weatherAPI.getWeatherData();
    print('@@@@@@ CityWeatherData: $cityWeatherData @@@@@@');
    return cityWeatherData;
  }
}
