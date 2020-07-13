import 'package:flutter/material.dart';

class IsFromSelected extends ChangeNotifier {
  bool _isFromSelected = true;

  bool get get => _isFromSelected;

  void set(bool fromSelected) {
    _isFromSelected = fromSelected;
    notifyListeners();
  }
}

IsFromSelected isFromSelected = IsFromSelected();
