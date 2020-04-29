import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutteridmemo/components/round_button.dart';
import 'package:flutteridmemo/cryption/e2ee.dart';
import 'package:flutteridmemo/database/hive_db.dart';
import 'package:hive/hive.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  E2EE e2ee = E2EE();
  String _randomKey = '';
  Box<String> databaseBox;
  String _id;
  String _pw;

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
            onChanged: (inPutPW) {
              _pw = inPutPW;
            },
          ),
          SizedBox(
            height: 100,
          ),
          IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () {
                Navigator.pop(context);
              }),
          SizedBox(
            height: 100,
          ),
          RoundButton(
              title: 'gogo',
              onPressed: () async {
                try {
                  final newUsr = await _auth.createUserWithEmailAndPassword(
                      email: _id, password: _pw);

                  if (newUsr != null) {
                    HiveDB().saveKey(_randomKey);
                    await Firestore.instance.collection(_id).add({
                      'id': DateTime.now().toString(),
                      'title': await e2ee.encryptE2EE('사이트', _randomKey),
                      'usrID': await e2ee.encryptE2EE('아이디', _randomKey),
                      'usrPW': await e2ee.encryptE2EE('비밀번호', _randomKey),
                      'text': await e2ee.encryptE2EE('메모', _randomKey),
                      'createTime': DateTime.now().year.toString(),
                    });
                    Navigator.pop(context);
                    _idController.clear();
                    _pwController.clear();
                  }
                } catch (e) {
                  print(e);
                }
              },
              color: Colors.blue)
        ],
      )),
    );
  }
}
