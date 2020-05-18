import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutteridmemo/components/dialog_frame.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/database/hive_db.dart';
import 'package:google_fonts/google_fonts.dart';

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  DialogFrame _dialog = DialogFrame();
  HiveDB _hiveDB = HiveDB();
  String _randomKey = '';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  FocusNode _emailFocusNode;
  FocusNode _pwFocusNode;

  void _buildFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  initPlatformState() async {
    final crypt = new PlatformStringCryptor();
    final key = await crypt.generateRandomKey();
    print("@@@@@@ RandomKey: $key @@@@@@");

    setState(() {
      _randomKey = key;
    });
  }

  @override
  void initState() {
    initPlatformState();
    _emailFocusNode = FocusNode();
    _pwFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _emailFocusNode.dispose();
    _pwFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildTitle(),
              buildForm(),
              buildBtn(context),
            ],
          ),
        ),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      '회원가입',
      style: GoogleFonts.jua(
        textStyle: TextStyle(
          color: kColorBlue,
          fontSize: 60.0,
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildEmailTextField(),
          SizedBox(height: 20.0),
          buildPwTextFormField(),
        ],
      ),
    );
  }

  TextFormField buildEmailTextField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      autofocus: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        _buildFocusChange(
            _formKey.currentContext, _emailFocusNode, _pwFocusNode);
      },
      validator: (String value) {
        if (value.isEmpty) {
          return '이메일을 입력해주세요.';
        } else if (!value.contains('@') || !value.contains('.com')) {
          return '정확한 이메일을 입력해주세요.';
        }
        return null;
      },
      decoration: kBlueTextFieldDecoration.copyWith(labelText: '이메일'),
    );
  }

  TextFormField buildPwTextFormField() {
    return TextFormField(
      controller: _pwController,
      focusNode: _pwFocusNode,
      autofocus: false,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        _pwFocusNode.unfocus();
      },
      validator: (String value) {
        if (value.isEmpty) {
          return '비밀번호를 입력해주세요.';
        } else if (value.length < 6) {
          return '비밀번호는 6자리 이상으로 입력해주세요.';
        }
        return null;
      },
      decoration: kBlueTextFieldDecoration.copyWith(labelText: '비밀번호'),
    );
  }

  Row buildBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        buildCancelBtn(context),
        SizedBox(width: 20.0),
        buildSingUpBtn(context),
      ],
    );
  }

  Expanded buildCancelBtn(BuildContext context) {
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

  Widget buildSingUpBtn(BuildContext context) {
    return Expanded(
      child: RoundBtnFrame(
        title: '회원가입',
        color: kColorBlue,
        textColor: kColorGrey,
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            try {
              final newUsr = await _firebaseAuth.createUserWithEmailAndPassword(
                  email: _emailController.text, password: _pwController.text);

              if (newUsr.user != null) {
                _hiveDB.saveKey(_randomKey);
                _hiveDB.saveUsrEmail(_emailController.text);

                newUsr.user.sendEmailVerification().whenComplete(
                  () {
                    _firebaseAuth.signOut();
                  },
                );

                _dialog
                    .getCompleteDialog(
                        context,
                        '회원가입 성공',
                        '회원가입 인증 메일 확인시\n 로그인 가능합니다.',
                        '확인',
                        _dialog.kBlueAlertStyle)
                    .show()
                    .whenComplete(
                  () {
                    Navigator.pop(context);
                  },
                );
              }
            } catch (e) {
              print(e);
            }
          }
        },
      ),
    );
  }
}
