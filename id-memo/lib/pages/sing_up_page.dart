import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutteridmemo/components/dialog_frame.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/database/hive_db.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  DialogFrame _dialog = DialogFrame();
  HiveDB _hiveDB = HiveDB();
  String _randomKey = '';
  bool _isCheck = false;

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

  _launchURL() async {
    const url = 'https://idmemomemo.blogspot.com/2020/05/blog-post.html';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, universalLinksOnly: true);
    } else {
      throw 'Could not launch $url';
    }
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
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              buildTitle(),
              SizedBox(height: kSize.height * 0.1),
              buildForm(),
              buildTermsConditions(context),
              SizedBox(height: kSize.height * 0.03),
              buildInformation(),
              SizedBox(height: kSize.height * 0.03),
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
          fontSize: 50.0,
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
        }
        String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
            "\\@" +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
            "(" +
            "\\." +
            "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
            ")+";
        RegExp regExp = new RegExp(p);
        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return '이메일을 정확하게 입력해주세요.';
        }
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

  ListTile buildTermsConditions(BuildContext context) {
    return ListTile(
      leading: buildCheckbox(),
      title: Text('개인정보취급방침'),
      trailing: buildContents(context),
    );
  }

  Container buildInformation() {
    return Container(
      child: Text(
        '* 데이터를 암호화하여 안전하게 저장하기 위해서 어플을 삭제하거나 다른 기기에서 로그인 할시 모든 정보를 확인할 수 없습니다.',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  Checkbox buildCheckbox() {
    return Checkbox(
      value: _isCheck,
      activeColor: kColorBlue,
      checkColor: kColorBlack,
      onChanged: (bool checked) {
        setState(
          () {
            _isCheck = checked;
          },
        );
      },
    );
  }

  InkWell buildContents(BuildContext context) {
    return InkWell(
      onTap: _launchURL,
      child: Icon(Icons.arrow_forward_ios),
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
            if (_isCheck) {
              try {
                final newUsr =
                    await _firebaseAuth.createUserWithEmailAndPassword(
                        email: _emailController.text,
                        password: _pwController.text);

                if (newUsr.user != null) {
                  _hiveDB.saveKey(_randomKey);
                  newUsr.user.sendEmailVerification().whenComplete(
                    () {
                      _firebaseAuth.signOut();
                    },
                  );

                  _dialog
                      .getCompleteDialog(
                          context,
                          '회원가입 성공',
                          '회원가입 인증 메일 확인시로그인 가능합니다.',
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
            } else {
              _dialog
                  .getCompleteDialog(context, '오류', '개인정보취급방침 확인을 해주세요.', '확인',
                      _dialog.kRedAlertStyle)
                  .show();
            }
          }
        },
      ),
    );
  }
}
