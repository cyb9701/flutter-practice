import 'package:flutter/material.dart';

class IsUpdating extends ChangeNotifier {
  bool _isUpdating = false;

  bool get getUpdating => _isUpdating;

  void setUpdating(bool isUpdating) {
    _isUpdating = isUpdating;
    notifyListeners();
  }
}

IsUpdating isUpdating = IsUpdating();
