import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/data/user.dart';

class MyUserData extends ChangeNotifier {
  User _myUserData;

  User get getData => _myUserData;

  void setUserData(User user) {
    _myUserData = user;
    notifyListeners();
  }

  void cleanUserData() {
    _myUserData = null;
  }
}
