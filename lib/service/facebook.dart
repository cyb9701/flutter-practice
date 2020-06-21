import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterinstagramclone/utils/simple_snack_bar.dart';

class Facebook {
  void facebookLogIn(BuildContext context) async {
    final facebook = FacebookLogin();
    final result = await facebook.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        handleToken(context, result.accessToken.token);
        simpleSnackBar(context, '로그인이 성공되었습니다. 잠시만 기달려주세요.');
        break;
      case FacebookLoginStatus.cancelledByUser:
        simpleSnackBar(context, '로그인이 취소되었습니다.');
        break;
      case FacebookLoginStatus.error:
        simpleSnackBar(context, '문제가 발생했습니다. 다시 실행해주세요.');
        break;
    }
  }

  void handleToken(BuildContext context, String token) async {
    final AuthCredential credential =
        FacebookAuthProvider.getCredential(accessToken: token);
    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      simpleSnackBar(context, '문제가 발생했습니다. 다시 실행해주세요.');
      print(e);
    }
  }
}
