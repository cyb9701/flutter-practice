import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/widget/sign_up_form.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          SignUpForm(),
          buildSingUpBtn(context),
        ],
      ),
    );
  }

  Positioned buildSingUpBtn(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: FlatButton(
        padding: EdgeInsets.all(20.0),
        shape: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '이미 계정이 있으신가요?',
                style: TextStyle(color: Colors.grey),
              ),
              TextSpan(text: ' '),
              TextSpan(
                text: '로그인',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
