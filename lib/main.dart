import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/firebase/firestore_provider.dart';
import 'package:flutterinstagramclone/pages/log_in_page.dart';
import 'package:flutterinstagramclone/pages/main_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<MyUserData>(
        create: (context) => MyUserData(),
        child: MyApp(),
      ),
    );

bool isItFirstData = true;

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
                firestoreProvider.attemptCreateUser(
                    userKey: snapshot.data.uid, email: snapshot.data.email);
                var myUserData = Provider.of<MyUserData>(context);
                firestoreProvider
                    .connectMyUserData(snapshot.data.uid)
                    .listen((data) {
                  myUserData.setUserData(data);
                });
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
