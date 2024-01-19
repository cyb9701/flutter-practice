import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/dialog_frame.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class FindPwPage extends StatefulWidget {
  @override
  _FindPwPageState createState() => _FindPwPageState();
}

class _FindPwPageState extends State<FindPwPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  DialogFrame _dialog = DialogFrame();

  @override
  Widget build(BuildContext context) {
    kSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 30.0),
      decoration: BoxDecoration(
        color: kColorBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kRadiusValue40),
          topRight: Radius.circular(kRadiusValue40),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildContainerBar(),
          SizedBox(height: 20.0),
          buildTitle(),
          SizedBox(height: 5.0),
          buildInformation(),
          SizedBox(height: 50.0),
          buildTextField(),
          SizedBox(height: 20.0),
          buildBtn(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Container buildContainerBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kSize.width * 0.30),
      height: 5.0,
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(kRadiusValue40),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      '비밀번호 재설정',
      textAlign: TextAlign.center,
      style: GoogleFonts.jua(
        textStyle: kAddPageTitleTextStyle,
      ),
    );
  }

  Widget buildInformation() {
    return Text('* 입력하신 이메일로 비밀번호 재설정 링크가 전송이 됩니다.');
  }

  Form buildTextField() {
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: _emailController,
        decoration: kTextFieldDecoration.copyWith(labelText: '이메일'),
        validator: (value) {
          if (value.isEmpty) {
            return '이메일을 입력해주세요.';
          }
          return null;
        },
      ),
    );
  }

  Widget buildBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildCancelBtn(),
        SizedBox(width: 20.0),
        buildPwResetBtn(),
      ],
    );
  }

  Expanded buildCancelBtn() {
    return Expanded(
      child: RoundBtnFrame(
        title: '취소',
        onPressed: () {
          Navigator.pop(context);
        },
        color: kColorGrey,
        textColor: Colors.white70,
      ),
    );
  }

  Expanded buildPwResetBtn() {
    return Expanded(
      child: RoundBtnFrame(
        title: '재설정',
        onPressed: () {
          if (_formKey.currentState.validate()) {
            FirebaseAuth.instance
                .sendPasswordResetEmail(email: _emailController.text)
                .whenComplete(() {
              _dialog
                  .getCompleteDialog(
                      context,
                      '재설정 성공',
                      '입력하신 이메일로 비밀번호 재설정 링크가 전송되었습니다.',
                      '확인',
                      _dialog.kBlueAlertStyle)
                  .show()
                  .whenComplete(() {
                Navigator.pop(context);
              });
            });
          }
        },
        color: kColorGreen,
        textColor: kColorGrey,
      ),
    );
  }
}
