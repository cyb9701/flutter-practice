import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/dialog_frame.dart';
import 'package:flutteridmemo/components/menu_clipper.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/database/hive_db.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

class SideBarPage extends StatefulWidget {
  @override
  _SideBarPageState createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage>
    with SingleTickerProviderStateMixin<SideBarPage> {
  AnimationController _animationController;
  StreamController<bool> isOpenedStreamController;
  Stream<bool> isOpenedStream;
  StreamSink<bool> isOpenedSink;
  final usrEmail = HiveDB().getUsrEmail();
  DialogFrame _dialog = DialogFrame();

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isOpenedSink.add(true);
      _animationController.forward();
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    HiveDB().saveUsrEmail(null);
    isOpenedSink.add(false);
    _animationController.reverse();
    Navigator.pop(context);
  }

  withdrawAccount() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _dialog.getDeleteDialog(
        context, '회원탈퇴', '회원탈퇴를 하게 되면 사용자의 모든 정보가 삭제되며 복구 불가능합니다.', '탈퇴', '취소',
        () {
      user.delete().whenComplete(() {
        signOut();
      });
    }, () {
      Navigator.pop(context);
    }, _dialog.kRedAlertStyle).show();
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: kDuration);
    isOpenedStreamController = PublishSubject<bool>();
    isOpenedStream = isOpenedStreamController.stream;
    isOpenedSink = isOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isOpenedStreamController.close();
    isOpenedSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    kSize = MediaQuery.of(context).size;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isOpenedStream,
      builder: (context, isOpenedAsync) {
        return AnimatedPositioned(
          duration: kDuration,
          top: 0,
          bottom: 0,
          left: isOpenedAsync.data ? 0 : -kSize.width,
          right: isOpenedAsync.data ? kSize.width * 0.13 : kSize.width - 45.0,
          child: SafeArea(
            child: Row(
              children: <Widget>[
                buildSideMenu(),
                buildSidebarIcon(),
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded buildSideMenu() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(kRadiusValue10),
            bottomRight: Radius.circular(kRadiusValue10),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: kColorGreen,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(kRadiusValue10),
              bottomRight: Radius.circular(kRadiusValue10),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: kColorBlack,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(kRadiusValue10),
                bottomRight: Radius.circular(kRadiusValue10),
              ),
            ),
            margin: EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0),
            padding: EdgeInsets.fromLTRB(30.0, 100.0, 50.0, 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildUsrEmail(),
                buildSizedBoxH20(),
                buildLogOutBtn(),
                buildWithDraw(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildUsrEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: kColorGrey,
        borderRadius: BorderRadius.circular(kRadiusValue20),
      ),
      child: Text(
        usrEmail == null ? 'ERROR' : usrEmail,
        style: GoogleFonts.jua(textStyle: TextStyle(fontSize: 25.0)),
      ),
    );
  }

  InkWell buildLogOutBtn() {
    return InkWell(
      onTap: () {
        signOut();
      },
      child: ListTile(
        leading: Icon(
          Icons.exit_to_app,
          size: 30.0,
        ),
        title: Text(
          '로그아웃',
          style: GoogleFonts.notoSans(
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
      ),
    );
  }

  InkWell buildWithDraw() {
    return InkWell(
      onTap: () {
        withdrawAccount();
      },
      child: ListTile(
        leading: Icon(
          Icons.delete,
          size: 30.0,
        ),
        title: Text(
          '회원탈퇴',
          style: GoogleFonts.notoSans(
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
        ),
      ),
    );
  }

  Align buildSidebarIcon() {
    return Align(
      alignment: Alignment(0, -0.9),
      child: GestureDetector(
        onTap: () {
          onIconPressed();
        },
        child: ClipPath(
          clipper: MenuClipper(),
          child: Container(
            color: Colors.white,
            child: Container(
              width: 35.0,
              height: 110.0,
              color: kColorGreen,
              alignment: Alignment.centerLeft,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: _animationController.view,
                color: kColorBlack,
                size: 27.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSizedBoxH20() => SizedBox(height: 20.0);
}
