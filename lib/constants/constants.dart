import 'package:flutter/material.dart';

Size kSize;

const kColorGreen = Color(0xFF54B386);
const kColorBlack = Color(0xFF232528);
const kColorGrey = Color(0xFF2B2F32);
const kColorBlue = Color(0xFF059FFF);

const kColorYoutube = '0xFFe53222';
const kColorFacebook = '0xFF4967ad';
const kColorKakao = '0xFFf3d749';
const kColorInstagram = '0xFFc92b52';
const kColorNaver = '0xFF5ac351';
const kColorGoogle = '0xFF5084ed';
const kColorDaum = '0xFF448eee';
const kColorDiscord = '0xFF667ac2';
const kColorNetflix = '0xFFa12423';

const kDuration = Duration(milliseconds: 500);

const double kRadiusValue10 = 10.0;
const double kRadiusValue15 = 15.0;
const double kRadiusValue20 = 20.0;
const double kRadiusValue40 = 40.0;

const kAddPageTitleTextStyle = TextStyle(fontSize: 35.0);
const kMemoTitleTextStyle =
    TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);
const kMemoIDPWTextStyle = TextStyle(fontSize: 20.0);
const kMemoTextTextStyle = TextStyle(fontSize: 15.0);
const kButtonTextStyle = TextStyle(fontSize: 25);

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
  labelStyle: TextStyle(fontSize: 18.0, color: Colors.white54),
  filled: false,
);

const kBlueTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(kRadiusValue10)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorBlue, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(kRadiusValue10)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: kColorBlue, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(kRadiusValue10)),
  ),
  labelText: '',
  labelStyle: TextStyle(fontSize: 18.0, color: Colors.white54),
  filled: false,
);
