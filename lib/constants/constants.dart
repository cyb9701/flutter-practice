import 'package:flutter/material.dart';

Size kSize;

const kColorGreen = Color(0xFF54B386);
const kColorBlack = Color(0xFF232528);
const kColorGrey = Color(0xFF2B2F32);
const kColorBlue = Color(0xFF059FFF);

const kDuration = Duration(milliseconds: 500);

const double kRadiusValue10 = 10.0;
const double kRadiusValue20 = 20.0;
const double kRadiusValue40 = 40.0;

const kAddPageTitleTextStyle = TextStyle(fontSize: 35.0);
const kMemoTitleTextStyle =
    TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);
const kMemoIDPWTextStyle = TextStyle(fontSize: 20.0);
const kMemoTextTextStyle = TextStyle(fontSize: 15.0);
const kButtonTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(kRadiusValue10)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorGreen, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(kRadiusValue10)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorGreen, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(kRadiusValue10)),
  ),
  labelText: '',
  labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
  filled: false,
);

//const kMessageTextFieldDecoration = InputDecoration(
//  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//  hintText: 'Type your message here...',
//  border: InputBorder.none,
//);
//
//const kMessageContainerDecoration = BoxDecoration(
//  border: Border(
//    top: BorderSide(color: Colors.greenAccent, width: 2.0),
//    bottom: BorderSide(color: Colors.greenAccent, width: 2.0),
//  ),
//);
