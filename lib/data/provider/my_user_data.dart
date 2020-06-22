import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/data/user.dart';

class MyUserData extends ChangeNotifier {
  User _myUserData;

  void setUserData(User user) {
    _myUserData = user;
    notifyListeners();
  }

  User get getData => _myUserData;
}
