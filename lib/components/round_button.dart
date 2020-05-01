import 'package:flutter/material.dart';
import 'package:flutteridmemo/constants/constants.dart';

class RoundButton extends StatelessWidget {
  RoundButton({
    @required this.title,
    @required this.onPressed,
    @required this.color,
    @required this.icon,
  });

  final String title;
  final Function onPressed;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(kRadiusValue20),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(kRadiusValue20),
                      color: Colors.white),
                  child: Icon(
                    icon,
                    size: 30.0,
                    color: color,
                  ),
                ),
                Text(
                  title,
                  style: kButtonTextStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
