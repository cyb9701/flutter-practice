import 'package:flutter/material.dart';
import 'package:fluttertiempo/pages/main_page.dart';
import 'package:fluttertiempo/provider/pos.dart';
import 'package:fluttertiempo/provider/sigma.dart';
import 'package:provider/provider.dart';

class WeatherBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Consumer<Pos>(
          builder: (context, pos, child) {
            return Positioned.fill(
              child: Transform.translate(
                offset: Offset((size.width / 2) * pos.curPos, 0),
                child: Image.asset(
                  'assets/city${pos.curPage}.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Consumer<Sigma>(
          builder: (context, sigma, child) {
            return Container();
          },
        ),
      ],
    );
  }
}
