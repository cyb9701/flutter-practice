import 'package:flutter/material.dart';

class IsFromSelected extends ChangeNotifier {
  bool _isFromSelected = true;

  bool get getSelected => _isFromSelected;

  void setSelected(bool fromSelected) {
    _isFromSelected = fromSelected;
    notifyListeners();
  }
}

IsFromSelected isFromSelected = IsFromSelected();
