import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cryptocurrency_xrate/constants/color.dart';
import 'package:flutter_cryptocurrency_xrate/constants/size.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double iconSize = 100.0;
    bool _test = true;
    if (kSize == null) kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            height: kSize.height / 2,
            child: Container(
              color: kDarkColor,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: kSize.height / 2,
            child: Container(
              color: kLightColor,
            ),
          ),
          Positioned(
            width: iconSize,
            height: iconSize,
            child: Container(
              decoration: BoxDecoration(
                color: kLightColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            width: iconSize,
            height: iconSize,
            child: Transform.rotate(
              angle: _test ? pi : 0,
              child: Image.asset(
                'assets/scroll_up.png',
                color: _test ? kBtnColor : kDarkColor,
              ),
            ),
          ),
          Positioned(
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
          ),
        ],
      ),
    );
  }
}
