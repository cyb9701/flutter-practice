import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/pages/log_in_page.dart';
import 'package:flutteridmemo/pages/memo_page.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox<String>("DB");
  runApp(MyApp()
//    DevicePreview(
//      enabled: true,
//      builder: (context) => MyApp(),
//    ),
      );
}

bool isFirstData = true;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        canvasColor: Colors.transparent,
      ),
      title: 'ID MEMO',
      home: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (isFirstData) {
            isFirstData = false;
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData && snapshot.data.isEmailVerified == true) {
              return MemoPage(userEmail: snapshot.data.email);
            } else {
              return LogInPage();
            }
          }
        },
      ),
    );
  }
}
