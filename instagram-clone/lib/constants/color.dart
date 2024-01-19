import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/size.dart';

const kAppBarColor = Color(0xFF111213);
const kBackgroundColor = Color(0xFF000001);
const kMenuColor = Color(0xFF252627);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.all(10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(kTextFieldRadius)),
  ),
  focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kTextFieldRadius)),
      borderSide: BorderSide(color: Colors.grey)),
  enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kTextFieldRadius)),
      borderSide: BorderSide(color: Colors.grey)),
  disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(kTextFieldRadius)),
      borderSide: BorderSide(color: Colors.grey)),
  labelStyle: TextStyle(color: Colors.grey),
  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0),
);
