import 'package:flutter/material.dart';

class CachedCurrency extends ChangeNotifier {
  String fsym = "BTC";
  String tsym = "USD";
  double conversion = 0;
  double fvalue = 1;
  double tvalue = 0;

  void setNewConversion(Map<String, dynamic> newConversion, bool isFromChange) {
    conversion = newConversion[tsym] ?? 0.0;
    print('---- $fsym->$tsym = $conversion ----');
    print('---- $fvalue || $tvalue ----');
    if (isFromChange) {
      this.tvalue = this.conversion * this.fvalue;
    } else {
      this.fvalue = this.tvalue / this.conversion;
    }
    print('---- after conversion ----');
    print('---- $fvalue || $tvalue ----');
    notifyListeners();
  }

  void setNewFValue(double newFValue) {
    this.fvalue = newFValue;
    this.tvalue = newFValue * conversion;
    notifyListeners();
  }

  void setNewTValue(double newTValue) {
    this.fvalue = this.fvalue / conversion;
    this.tvalue = newTValue;
  }
}

CachedCurrency cachedCurrency = CachedCurrency();
