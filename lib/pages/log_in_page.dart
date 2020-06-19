import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/pages/sign_up_page.dart';
import 'package:flutterinstagramclone/widget/log_in_form.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (kSize == null) kSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          LogInForm(),
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
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUpPage()));
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '계정이 없으신가요?',
                style: TextStyle(color: Colors.grey),
              ),
              TextSpan(text: ' '),
              TextSpan(
                text: '가입하기',
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
