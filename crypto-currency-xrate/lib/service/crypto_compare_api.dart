import 'package:dio/dio.dart';
import 'package:flutter_cryptocurrency_xrate/constants/api_key.dart';

class CryptoCompareAPI {
  Future<Map<String, dynamic>> getCurrency(String fsym, String tsyms) async {
    Map<String, dynamic> _map = {};
    _map.putIfAbsent('fsym', () => fsym);
    _map.putIfAbsent('tsyms', () => tsyms);
    _map.putIfAbsent('api_key', () => API_KEY);

    Response response = await Dio().get(
        "https://min-api.cryptocompare.com/data/price",
        queryParameters: _map);

    return response.data;
  }
}

CryptoCompareAPI cryptoCompareAPI = CryptoCompareAPI();
