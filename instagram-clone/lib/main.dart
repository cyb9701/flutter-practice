import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/firebase/database.dart';
import 'package:flutterinstagramclone/pages/log_in_page.dart';
import 'package:flutterinstagramclone/pages/main_page.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      ChangeNotifierProvider<MyUserData>(
        create: (context) => MyUserData(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        title: 'Instagram Clone',
        theme: ThemeData.dark(),
        home: Consumer<MyUserData>(
          builder: (context, myUserData, child) {
            switch (myUserData.getUserDataStatus) {
              case MyUserDataStatus.progress:
                // check current user.
                FirebaseAuth.instance.currentUser().then(
                  (firebaseUser) {
                    if (firebaseUser == null) {
                      // Make Status none.
                      myUserData.setNewUserDataStatus(MyUserDataStatus.none);
                    } else {
                      // if current user exist, connect firebase to app, and save user data.
                      database.connectMyUserData(firebaseUser.uid).listen(
                        (userData) {
                          myUserData.setUserData(userData);
                        },
                      );
                    }
                  },
                );
                return Container(
                  color: kBackgroundColor,
                );
              case MyUserDataStatus.exist:
                return MainPage();
              default:
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
