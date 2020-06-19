import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/pages/log_in_page.dart';
import 'package:flutterinstagramclone/pages/main_page.dart';

void main() => runApp(MyApp());

bool isItFirstData = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          canvasColor: Colors.transparent,
        ),
        home: StreamBuilder<FirebaseUser>(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (isItFirstData) {
              isItFirstData = false;
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return MainPage();
              }
              return LogInPage();
            }
          },
        ),
      ),
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
    );
  }
}
