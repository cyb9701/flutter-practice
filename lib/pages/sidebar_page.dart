import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/dialog_frame.dart';
import 'package:flutteridmemo/components/menu_clipper.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/pages/log_in_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rxdart/rxdart.dart';

class SideBarPage extends StatefulWidget {
  SideBarPage({@required this.userEmail});

  final String userEmail;

  @override
  _SideBarPageState createState() => _SideBarPageState();
}

class _SideBarPageState extends State<SideBarPage>
    with SingleTickerProviderStateMixin<SideBarPage> {
  AnimationController _animationController;
  StreamController<bool> isOpenedStreamController;
  Stream<bool> isOpenedStream;
  StreamSink<bool> isOpenedSink;
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

  signOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LogInPage()),
        (Route<dynamic> route) => false);
  }

  withdrawAccount() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    _dialog.getDeleteDialog(
        context, '회원탈퇴', '회원탈퇴를 하게 되면 사용자의 모든 정보가 삭제되며 복구 불가능합니다.', '탈퇴', '취소',
        () {
      Firestore().collection(widget.userEmail).getDocuments().then((snapshots) {
        for (DocumentSnapshot snapshot in snapshots.documents) {
          snapshot.reference.delete();
        }
      }).whenComplete(() {
        user.delete();
        signOut();
        Navigator.pop(context);
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
            padding: EdgeInsets.fromLTRB(30.0, 100.0, 50.0, 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    buildUsrEmail(),
                    SizedBox(height: 20.0),
                    buildLogOutBtn(),
                    buildWithDraw(),
                  ],
                ),
                buildDeveloperEmail(),
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
        widget.userEmail == null ? 'ERROR' : widget.userEmail,
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
          Icons.cloud_off,
          size: 30.0,
        ),
        title: Text(
          '회원탈퇴',
          style: GoogleFonts.notoSans(
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  ListTile buildDeveloperEmail() {
    return ListTile(
      leading: Icon(
        Icons.email,
        color: Colors.white70,
      ),
      title: Text(
        'cyb9701@gmail.com',
        style: GoogleFonts.notoSans(
          textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
      subtitle: Text(
        '개발자 이메일',
        style: GoogleFonts.notoSans(
          textStyle: TextStyle(
            color: Colors.white70,
          ),
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
}
