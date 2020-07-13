import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency_xrate/constants/color.dart';
import 'package:flutter_cryptocurrency_xrate/constants/size.dart';
import 'package:flutter_cryptocurrency_xrate/provider/is_from_selected.dart';
import 'package:flutter_cryptocurrency_xrate/widgets/currency_widget.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double iconSize = 100.0;
    bool _test = false;
    if (kSize == null) kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _fromCurrency(),
          _toCurrency(),
          _circleBackground(iconSize),
          _arrowAsset(iconSize, _test),
          _circleProgressAnimation(iconSize, _test),
        ],
      ),
    );
  }

  Positioned _fromCurrency() {
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      height: kSize.height / 2,
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
      height: kSize.height / 2,
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

  Positioned _arrowAsset(double iconSize, bool _test) {
    return Positioned(
      width: iconSize,
      height: iconSize,
      child: Consumer<IsFromSelected>(
        builder: (context, value, child) {
          return Transform.rotate(
            angle: value.getSelected ? pi : 0,
            child: Image.asset(
              'assets/scroll_up.png',
              color: kBtnColor,
            ),
          );
        },
      ),
    );
  }

  Positioned _circleProgressAnimation(double iconSize, bool _test) {
    return Positioned(
      width: iconSize,
      height: iconSize,
      child: Visibility(
        visible: _test,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: CircularProgressIndicator(
            strokeWidth: 6,
            backgroundColor: kLightColor,
            valueColor: AlwaysStoppedAnimation<Color>(kBtnColor),
          ),
        ),
      ),
    );
  }
}
