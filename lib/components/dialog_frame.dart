import 'package:flutter/material.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DialogFrame {
  var kBlueAlertStyle = AlertStyle(
    backgroundColor: kColorBlack,
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    titleStyle: TextStyle(
        color: kColorBlue, fontWeight: FontWeight.bold, fontSize: 25.0),
    descStyle: TextStyle(color: Colors.white),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kRadiusValue20),
    ),
  );

  var kRedAlertStyle = AlertStyle(
    backgroundColor: kColorBlack,
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    titleStyle: TextStyle(
        color: Color(int.parse(kColorYoutube)),
        fontWeight: FontWeight.bold,
        fontSize: 25.0),
    descStyle: TextStyle(color: Colors.white),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kRadiusValue20),
    ),
  );

  var kDeleteAlertStyle = AlertStyle(
    backgroundColor: kColorBlack,
    animationType: AnimationType.fromTop,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    titleStyle: TextStyle(
        color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0),
    descStyle: TextStyle(color: Colors.white, fontWeight: null, fontSize: 17.0),
    animationDuration: Duration(milliseconds: 400),
    alertBorder: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kRadiusValue20),
    ),
  );

  Alert getCompleteDialog(BuildContext context, String title, String desc,
      String btn, AlertStyle style) {
    return Alert(
      context: context,
      style: style,
      type: AlertType.none,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            btn,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: kColorGreen,
          radius: BorderRadius.circular(kRadiusValue10),
        ),
      ],
    );
  }

  Alert getDeleteDialog(
      BuildContext context,
      String title,
      String desc,
      String btn1,
      String btn2,
      Function onPressed1,
      Function onPressed2,
      AlertStyle style) {
    return Alert(
      context: context,
      style: style,
      type: AlertType.none,
      title: title,
      desc: desc,
      buttons: [
        DialogButton(
          child: Text(
            btn1,
            style:
                TextStyle(color: Color(int.parse(kColorYoutube)), fontSize: 20),
          ),
          onPressed: onPressed1,
          color: kColorGrey,
          radius: BorderRadius.circular(kRadiusValue10),
        ),
        DialogButton(
          child: Text(
            btn2,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: onPressed2,
          color: kColorGrey,
          radius: BorderRadius.circular(kRadiusValue10),
        ),
      ],
    );
  }
}
