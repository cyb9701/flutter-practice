import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/dialog_frame.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/database/hive_db.dart';
import 'package:flutteridmemo/pages/find_pw_page.dart';
import 'package:flutteridmemo/pages/memo_page.dart';
import 'package:flutteridmemo/pages/sing_up_page.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  DialogFrame _dialog = DialogFrame();
  final usrEmail = HiveDB().getUsrEmail();

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
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    buildIconTitle(),
                    SizedBox(height: kSize.height * 0.15),
                    buildForm(),
                    SizedBox(height: 5.0),
                    buildFindPWBtn(),
                    SizedBox(height: kSize.height * 0.03),
                    buildLogInBtn(),
                  ],
                ),
              ),
            ),
            buildSingUpBtn(),
          ],
        ),
      ),
    );
  }

  Row buildIconTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildTitleIcon(),
        SizedBox(width: 20.0),
        buildTitle(),
      ],
    );
  }

  Widget buildTitleIcon() {
    return Icon(
      Icons.vpn_key,
      size: 40.0,
    );
  }

  Widget buildTitle() {
    return Text(
      'ID MEMO',
      style: GoogleFonts.jua(
        textStyle: TextStyle(
          color: kColorGreen,
          fontSize: 60.0,
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
      validator: (String value) {
        if (value.isEmpty) {
          return '이메일을 입력해주세요.';
        } else if (!value.contains('@') || !value.contains('.com')) {
          return '정확한 이메일을 입력해주세요.';
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
      validator: (String value) {
        if (value.isEmpty) {
          return '비밀번호를 입력해주세요.';
        } else if (value.length < 6) {
          return '비밀번호는 6자리 이상으로 입력해주세요.';
        }
        return null;
      },
      decoration: kTextFieldDecoration.copyWith(labelText: '비밀번호'),
    );
  }

  InkWell buildFindPWBtn() {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: FindPwPage(),
            ),
          ),
        );
      },
      child: Text(
        '비밀번호 재설정하기',
        textAlign: TextAlign.end,
      ),
    );
  }

  RoundBtnFrame buildLogInBtn() {
    return RoundBtnFrame(
      title: '로그인',
      color: kColorGreen,
      textColor: kColorGrey,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          final logInUsr = await _firebaseAuth.signInWithEmailAndPassword(
              email: _emailController.text, password: _pwController.text);
          try {
            if (logInUsr.user.isEmailVerified == true) {
              if (logInUsr != null) {
                if (usrEmail.toString() == _emailController.text.toString()) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MemoPage()));
                } else {
                  HiveDB().saveUsrEmail(_emailController.text);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MemoPage()));
                }
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
            child: Text(
              '  회원가입하기',
              style: TextStyle(
                  color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingUpPage(),
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
