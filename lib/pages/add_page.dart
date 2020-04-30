import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/round_button.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/cryption/e2ee.dart';
import 'package:flutteridmemo/database/hive_db.dart';
import 'package:flutteridmemo/utils/admob_service.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  AddPage({this.logInUsr});

  final String logInUsr;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final Firestore _fireStore = Firestore.instance;
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();
  FocusNode nodeFour = FocusNode();
  E2EE e2ee = E2EE();
  String _key = HiveDB().getKey();
  String _title;
  String _usrID;
  String _usrPW;
  String _text;
  DateTime _createTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('@@@@@@ Key:${HiveDB().getKey()} @@@@@@');
  }

  @override
  Widget build(BuildContext context) {
    kSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 30.0),
        decoration: BoxDecoration(
          color: kColorGrey,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(kRadiusValue40),
            topRight: Radius.circular(kRadiusValue40),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildContainerBar(),
            buildSizedBoxH20(),
            buildTitle(),
            buildSizedBoxH50(),
            buildTitleTextField(),
            buildSizedBoxH10(),
            buildIDTextField(),
            buildSizedBoxH10(),
            buildPWTextField(),
            buildWarningText(),
            buildSizedBoxH20(),
            buildMemoTextField(),
            buildSizedBoxH20(),
            buildAddBtn(context),
          ],
        ),
      ),
    );
  }

  Container buildContainerBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kSize.width * 0.35),
      height: 4.0,
      decoration: BoxDecoration(
        color: kColorGreen,
        borderRadius: BorderRadius.circular(kRadiusValue40),
      ),
    );
  }

  Text buildTitle() {
    return Text(
      '메모 추가',
      textAlign: TextAlign.center,
      style: kAddPageTitleTextStyle.copyWith(fontWeight: FontWeight.bold),
    );
  }

  TextField buildTitleTextField() {
    return TextField(
        focusNode: nodeOne,
        controller: TextEditingController(),
        decoration: kTextFieldDecoration.copyWith(labelText: '사이트 이름'),
        onChanged: (String newTitle) async {
          final encryptTitle = await e2ee.encryptE2EE(newTitle, _key);
          _title = encryptTitle;
        });
  }

  TextField buildIDTextField() {
    return TextField(
        focusNode: nodeTwo,
        controller: TextEditingController(),
        decoration: kTextFieldDecoration.copyWith(
            labelText: '아이디', hintText: '예) ****@naver.com / 페이스북 로그인'),
        onChanged: (String newUsrID) async {
          final encryptUsrID = await e2ee.encryptE2EE(newUsrID, _key);
          _usrID = encryptUsrID;
        });
  }

  TextField buildPWTextField() {
    return TextField(
        focusNode: nodeThree,
        controller: TextEditingController(),
        decoration: kTextFieldDecoration.copyWith(labelText: '비밀번호'),
        onChanged: (String newUsrPW) async {
          final encryptUsrPW = await e2ee.encryptE2EE(newUsrPW, _key);
          _usrPW = encryptUsrPW;
        });
  }

  Text buildWarningText() {
    return Text(
      '* 사이트 이름, 아이디, 비밀번호는 필수 입력입니다.',
      style: TextStyle(color: Colors.redAccent),
      textAlign: TextAlign.end,
    );
  }

  TextField buildMemoTextField() {
    return TextField(
        focusNode: nodeFour,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        controller: TextEditingController(),
        decoration: kTextFieldDecoration.copyWith(
          labelText: '메모',
          contentPadding:
              EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        ),
        onChanged: (String newText) async {
          if (newText.isEmpty) {
            _text = null;
          } else {
            final encryptText = await e2ee.encryptE2EE(newText, _key);
            _text = encryptText;
          }
        });
  }

  Widget buildAddBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.2),
      child: RoundButton(
        title: '추가',
        onPressed: () {
          if (_title == null || _usrID == null || _usrPW == null) {
            print('@@@@@@ Title or UsrID is empty @@@@@@');
            Navigator.pop(context);
          } else {
            _createTime = DateTime.now();
            String dateFormat = DateFormat('MM.dd').format(_createTime);

            _fireStore.collection(widget.logInUsr).add({
              'id': _createTime.toString(),
              'title': _title,
              'usrID': _usrID,
              'usrPW': _usrPW,
              'text': _text,
              'createTime': dateFormat,
            });

            print('@@@@@@ Add New Memo @@@@@@');
            Navigator.pop(context);
            AdMobService().myInterstitialAd
              ..load()
              ..show(
                anchorType: AnchorType.bottom,
                anchorOffset: 0.0,
                horizontalCenterOffset: 0.0,
              );
          }
        },
        color: kColorGreen,
      ),
    );
  }

  SizedBox buildSizedBoxH10() => SizedBox(height: 10.0);

  SizedBox buildSizedBoxH20() => SizedBox(height: 20.0);

  SizedBox buildSizedBoxH50() => SizedBox(height: 50.0);

  SizedBox buildBannerSpace() => SizedBox(height: 90.0);
}
