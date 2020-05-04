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
  HiveDB hiveDB = HiveDB();
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
            color: Colors.blue,
            icon: Icons.person_add,
            onPressed: () async {
              try {
                final newUsr = await _auth.createUserWithEmailAndPassword(
                    email: _id, password: _pw);

                if (newUsr != null) {
                  hiveDB.saveKey(_randomKey);
                  hiveDB.saveUsrEmail(_id);
                  Navigator.pop(context);
                  _idController.clear();
                  _pwController.clear();
                }
              } catch (e) {
                print(e);
              }
            },
          ),
        ],
      )),
    );
  }
}
