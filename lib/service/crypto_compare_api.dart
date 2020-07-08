import 'package:dio/dio.dart';
import 'package:flutter_cryptocurrency_xrate/constants/api_key.dart';
import 'package:flutter_cryptocurrency_xrate/constants/simple_path.dart';

class CryptoCompareAPI {
  Future<Map<String, dynamic>> getCurrency(String crypto, String money) async {
    Map<String, dynamic> _map = {};
    _map.putIfAbsent(KEY_CRYPTO, () => crypto);
    _map.putIfAbsent(KEY_MONEY, () => money);
    _map.putIfAbsent(KEY_API_KEY, () => API_KEY);

    Response response = await Dio().get(
        "https://min-api.cryptocompare.com/data/price",
        queryParameters: _map);

    return response.data;
  }
}

CryptoCompareAPI cryptoCompareAPI = CryptoCompareAPI();
