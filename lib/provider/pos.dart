import 'package:flutter/material.dart';

class Pos extends ChangeNotifier {
  Pos(this._page);

  final int _page;
  double _pagePos = 0;

  void setPosition(double position) {
    _pagePos = position - _page;
    notifyListeners();
  }

  int get curPage => _page;

  double get curPos => _pagePos;
}
