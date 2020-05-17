import 'package:flutter/material.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundBtnFrame extends StatelessWidget {
  RoundBtnFrame({
    @required this.title,
    @required this.onPressed,
    @required this.color,
  });

  final String title;
  final Function onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(kRadiusValue15),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 50.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
              title,
              style: GoogleFonts.jua(
                  textStyle: kButtonTextStyle.copyWith(color: kColorGrey)),
            ),
          ),
        ),
      ),
    );
  }
}
