import 'package:geolocator/geolocator.dart';

class Location {
  double lat;
  double lon;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      lat = position.latitude;
      lon = position.longitude;
      print(lat);
      print('@@@@@@ Position:$position @@@@@@');
    } catch (e) {
      print(e);
    }
  }
}
