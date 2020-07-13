import 'package:flutter/material.dart';

class IsUpdating extends ChangeNotifier {
  bool _isUpdating = false;

  bool get get => _isUpdating;

  void set(bool isUpdating) {
    _isUpdating = isUpdating;
    notifyListeners();
  }
}

IsUpdating isUpdating = IsUpdating();
