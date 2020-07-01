import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/service/facebook.dart';
import 'package:flutterinstagramclone/utils/simple_snack_bar.dart';
import 'package:provider/provider.dart';

class LogInForm extends StatefulWidget {
  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _idController;
  TextEditingController _pwController;
  Facebook _facebook = Facebook();

  void _logIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _idController.text, password: _pwController.text);
      Provider.of<MyUserData>(context, listen: false)
          .setNewUserDataStatus(MyUserDataStatus.progress);
      print('@@@@@@ Email : ${_idController.text} @@@@@@');
      print('@@@@@@ EmailPW : ${_pwController.text} @@@@@@');
      print('@@@@@@ Succeed Log In @@@@@@');
    } catch (e) {
      simpleSnackBar(context, '아이디 혹은 비밀번호가 옳바르지 않습니다.');
      print(e);
    }
  }

  @override
  void initState() {
    _idController = TextEditingController();
    _pwController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kCommon_l_gap),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Spacer(flex: 9),
              logo(),
              Spacer(flex: 2),
              idTextFormField(),
              Spacer(flex: 1),
              pwTextFormField(),
              findPwBtn(),
              Spacer(flex: 2),
              logInBtn(context),
              Spacer(flex: 1),
              textDivider(),
              Spacer(flex: 1),
              facebookBtn(context),
              Spacer(flex: 9),
            ],
          ),
        ),
      ),
    );
  }

  Text logo() {
    return Text(
      'Instagram',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 60.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextFormField idTextFormField() {
    return TextFormField(
      controller: _idController,
      autofocus: false,
      decoration: kTextFieldDecoration.copyWith(
          labelText: '이메일', hintText: '전화번호, 사용자 이름 또는 이메일'),
      validator: (String value) {
        if (value.isEmpty) {
          return '이메일 혹은 전화번호를 입력해주세요.';
        }
        return null;
      },
    );
  }

  TextFormField pwTextFormField() {
    return TextFormField(
      controller: _pwController,
      autofocus: false,
      obscureText: true,
      decoration: kTextFieldDecoration.copyWith(labelText: '비밀번호'),
      validator: (String value) {
        if (value.isEmpty) {
          return '비밀번호를 입력해주세요.';
        } else if (value.length < 6) {
          return '비밀번호를 정확하게 입력해주세요.';
        }
        return null;
      },
    );
  }

  Align findPwBtn() {
    return Align(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {},
        child: Text(
          '비밀번호를 잊으셨나요?',
          style: TextStyle(
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  GestureDetector logInBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState.validate()) {
          _logIn();
        }
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(kBtnRadius),
        ),
        child: Text(
          '로그인',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Stack textDivider() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
        Container(
          color: kBackgroundColor,
          padding: EdgeInsets.all(15.0),
          child: Text(
            '또는',
          ),
        ),
      ],
    );
  }

  SignInButton facebookBtn(BuildContext context) {
    return SignInButton(
      Buttons.Facebook,
      text: "Facebook으로 로그인",
      onPressed: () {
        _facebook.facebookLogIn(context);
      },
    );
  }
}
