import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/data/user.dart';

class MyUserData extends ChangeNotifier {
  User _myUserData;
  MyUserDataStatus _myUserDataStatus = MyUserDataStatus.progress;

  User get getUserData => _myUserData;
  MyUserDataStatus get getUserDataStatus => _myUserDataStatus;

  void setUserData(User user) {
    _myUserData = user;
    _myUserDataStatus = MyUserDataStatus.exist;
    notifyListeners();
  }

  void setNewUserDataStatus(MyUserDataStatus status) {
    _myUserDataStatus = status;
    notifyListeners();
  }

  void cleanUserData() {
    _myUserData = null;
    _myUserDataStatus = MyUserDataStatus.none;
    notifyListeners();
  }

  bool amIFollowingOtherUser(String userKey) {
    return _myUserData.followings.contains(userKey);
  }
}

enum MyUserDataStatus { progress, exist, none }
