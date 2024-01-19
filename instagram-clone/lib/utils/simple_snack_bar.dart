import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';

void simpleSnackBar(BuildContext context, String text) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  currentFocus.unfocus();
  final SnackBar snackBar = SnackBar(
    content: Text(
      text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: kMenuColor,
  );
  Scaffold.of(context).showSnackBar(snackBar);
}
