import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertiempo/provider/sigma.dart';
import 'package:provider/provider.dart';

class WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            'assets/city3.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Consumer<Sigma>(
          builder: (context, sigma, child) {
            return Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: sigma.getSigma,
                  sigmaY: sigma.getSigma,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
