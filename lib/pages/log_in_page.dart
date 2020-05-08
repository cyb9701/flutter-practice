import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutteridmemo/components/dialog_frame.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/database/hive_db.dart';
import 'package:flutteridmemo/pages/memo_page.dart';
import 'package:flutteridmemo/pages/sign_up_page.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  final _firebaseAuth = FirebaseAuth.instance;
  DialogFrame _dialog = DialogFrame();
  String _randomKey = '';
  final key = HiveDB().getKey();
  final usrEmail = HiveDB().getUsrEmail();
  String _id;
  String _pw;

  initPlatformState() async {
    final crypt = new PlatformStringCryptor();
    final key = await crypt.generateRandomKey();

    setState(() {
      _randomKey = key;
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
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
      body: SafeArea(
          child: Column(
        children: <Widget>[
          TextFormField(
            controller: _idController,
            onChanged: (inPutID) {
              _id = inPutID;
            },
          ),
          SizedBox(
            height: 100,
          ),
          TextFormField(
            controller: _pwController,
            obscureText: true,
            onChanged: (inPutPW) {
              _pw = inPutPW;
            },
          ),
          SizedBox(
            height: 100,
          ),
          RoundBtnFrame(
            title: 'gogo',
            color: Colors.red,
            icon: Icons.arrow_forward,
            onPressed: () async {
              final logInUsr = await _firebaseAuth.signInWithEmailAndPassword(
                  email: _id, password: _pw);
              try {
                if (logInUsr.user.isEmailVerified == true) {
                  if (logInUsr != null) {
                    print('@@@@@@ Key: $key @@@@@@');
                    print('@@@@@@ UsrEmail: $usrEmail @@@@@@');
                    if (key == null) {
                      HiveDB().saveKey(_randomKey);
                    } else if (usrEmail != _id) {
                      HiveDB().saveUsrEmail(_id);
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
              } on PlatformException catch (e) {
                print(e);
              }
            },
          ),
          SizedBox(
            height: 100,
          ),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: Text('singup')),
        ],
      )),
    );
  }
}
