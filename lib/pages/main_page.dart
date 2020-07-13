import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency_xrate/constants/color.dart';
import 'package:flutter_cryptocurrency_xrate/constants/size.dart';
import 'package:flutter_cryptocurrency_xrate/provider/cached_currency.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_from_selected.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_updating.dart';
import 'package:flutter_cryptocurrency_xrate/service/crypto_compare_api.dart';
import 'package:flutter_cryptocurrency_xrate/widgets/currency_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double iconSize = 100.0;
    if (size == null) size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _fromCurrency(),
          _toCurrency(),
          _circleBackground(iconSize),
          _arrowAsset(iconSize),
          _circleProgressAnimation(context, iconSize),
        ],
      ),
    );
  }

  Positioned _fromCurrency() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      height: size.height / 2,
      child: Container(
        color: kDarkColor,
        child: CurrencyWidget(
          isFromCurrency: true,
        ),
      ),
    );
  }

  Positioned _toCurrency() {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      height: size.height / 2,
      child: Container(
        color: kLightColor,
        child: CurrencyWidget(
          isFromCurrency: false,
        ),
      ),
    );
  }

  Positioned _circleBackground(double iconSize) {
    return Positioned(
      width: iconSize,
      height: iconSize,
      child: Container(
        decoration: BoxDecoration(
          color: kLightColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Positioned _arrowAsset(double iconSize) {
    return Positioned(
      width: iconSize,
      height: iconSize,
      child: Consumer<IsFromSelected>(
        builder: (context, isFromSelected, child) {
          return Transform.rotate(
            angle: isFromSelected.get ? pi : 0,
            child: GestureDetector(
              onTap: () {
                Provider.of<IsUpdating>(context, listen: false).set(true);
                cryptoCompareAPI
                    .getCurrency(
                        Provider.of<CachedCurrency>(context, listen: false)
                            .fsym,
                        Provider.of<CachedCurrency>(context, listen: false)
                            .tsym)
                    .then(
                  (conversion) {
                    cachedCurrency.setNewConversion(
                        conversion, isFromSelected.get);
                    isUpdating.set(false);
                  },
                );
              },
              child: Image.asset(
                'assets/scroll_up.png',
                color: kBtnColor,
              ),
            ),
          );
        },
      ),
    );
  }

  Positioned _circleProgressAnimation(BuildContext context, double iconSize) {
    return Positioned(
      width: iconSize,
      height: iconSize,
      child: Consumer<IsUpdating>(
        builder: (context, isUpdating, child) {
          return Visibility(
            visible: isUpdating.get,
            child: Padding(
              padding: EdgeInsets.all(6),
              child: CircularProgressIndicator(
                strokeWidth: 6,
                backgroundColor: kLightColor,
                valueColor: AlwaysStoppedAnimation<Color>(kBtnColor),
              ),
            ),
          );
        },
      ),
    );
  }
}
