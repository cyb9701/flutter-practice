import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutteridmemo/components/round_button.dart';
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
  final _auth = FirebaseAuth.instance;
  String _randomKey = '';
  final key = HiveDB().getKey();
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
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          TextField(
            controller: _idController,
            onChanged: (inPutID) {
              _id = inPutID;
            },
          ),
          SizedBox(
            height: 100,
          ),
          TextField(
            controller: _pwController,
            obscureText: true,
            onChanged: (inPutPW) {
              _pw = inPutPW;
            },
          ),
          SizedBox(
            height: 100,
          ),
          RoundButton(
              title: 'gogo',
              onPressed: () async {
                try {
                  final logInUsr = await _auth.signInWithEmailAndPassword(
                      email: _id, password: _pw);
                  if (key == null) {
                    HiveDB().saveKey(_randomKey);
                  } else if (logInUsr != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MemoPage()));
                    _idController.clear();
                    _pwController.clear();
                  }
                } on PlatformException catch (e) {
                  print(e);
                }
              },
              color: Colors.red),
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
