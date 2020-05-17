import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutteridmemo/components/dialog_frame.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/database/hive_db.dart';
import 'package:flutteridmemo/pages/memo_page.dart';
import 'package:flutteridmemo/pages/sign_up_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  DialogFrame _dialog = DialogFrame();
  String _randomKey = '';
  final key = HiveDB().getKey();
  final usrEmail = HiveDB().getUsrEmail();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  FocusNode _emailFocusNode;
  FocusNode _pwFocusNode;

  initPlatformState() async {
    final crypt = new PlatformStringCryptor();
    final key = await crypt.generateRandomKey();

    setState(() {
      _randomKey = key;
    });
  }

  void _buildFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void initState() {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildTitleIcon(),
                      SizedBox(width: 10.0),
                      buildTitle(),
                    ],
                  ),
                  buildForm(),
                  buildFindPWBtn(),
                  buildLogInBtn(),
                ],
              ),
            ),
            buildSingUpBtn(),
          ],
        ),
      ),
    );
  }

  Icon buildTitleIcon() {
    return Icon(
      Icons.lock,
      size: 30.0,
    );
  }

  Text buildTitle() {
    return Text(
      'ID MEMO',
      style: GoogleFonts.jua(
        textStyle: TextStyle(
          color: kColorGreen,
          fontSize: 50.0,
        ),
      ),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildEmailTextFormField(),
          SizedBox(height: 20.0),
          buildPwTextFormField(),
        ],
      ),
    );
  }

  TextFormField buildEmailTextFormField() {
    return TextFormField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      autofocus: false,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        _buildFocusChange(
            _formKey.currentContext, _emailFocusNode, _pwFocusNode);
      },
      validator: (String title) {
        if (title.isEmpty) {
          return '이메일을 입력해주세요.';
        }
        return null;
      },
      decoration: kTextFieldDecoration.copyWith(labelText: '이메일'),
    );
  }

  TextFormField buildPwTextFormField() {
    return TextFormField(
      obscureText: true,
      controller: _pwController,
      focusNode: _pwFocusNode,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) {
        _pwFocusNode.unfocus();
      },
      validator: (String title) {
        if (title.isEmpty) {
          return '비밀번호를 입력해주세요.';
        }
        return null;
      },
      decoration: kTextFieldDecoration.copyWith(labelText: '비밀번호'),
    );
  }

  InkWell buildFindPWBtn() {
    return InkWell(
      onTap: () {},
      child: Text(
        '비밀번호를 잊으셨나요?',
        textAlign: TextAlign.end,
      ),
    );
  }

  RoundBtnFrame buildLogInBtn() {
    return RoundBtnFrame(
      title: '로그인',
      color: kColorGreen,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          final logInUsr = await _firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text, password: _pwController.text);
          try {
            if (logInUsr.user.isEmailVerified == true) {
              if (logInUsr != null) {
                print('@@@@@@ Key: $key @@@@@@');
                print('@@@@@@ UsrEmail: $usrEmail @@@@@@');
                if (key == null) {
                  HiveDB().saveKey(_randomKey);
                }
                if (usrEmail.toString() != _emailController.text.toString()) {
                  HiveDB().saveUsrEmail(_emailController.text);
                }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MemoPage()));
                _pwController.clear();
              }
            } else {
              _firebaseAuth.signOut();
              _dialog
                  .getCompleteDialog(
                      context,
                      '오류',
                      '이메일 인증이 완료되지 않았습니다.\n이메일 인증 후 로그인 가능합니다.',
                      '확인',
                      _dialog.kRedAlertStyle)
                  .show();
            }
          } catch (e) {
            print(e);
          }
        }
      },
    );
  }

  Container buildSingUpBtn() {
    return Container(
      width: kSize.width,
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('계정이 없으신가요?'),
          InkWell(
            child: Text('  회원가입하기'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignUpPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

//on PlatformException catch (e) {
//                print(e);
//              }
