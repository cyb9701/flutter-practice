import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/cryption/e2ee.dart';
import 'package:flutteridmemo/utils/admob_service.dart';
import 'package:flutteridmemo/utils/site_color.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  AddPage({this.logInUsr});

  final String logInUsr;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final Firestore _fireStore = Firestore.instance;
  E2EE e2ee = E2EE();
  DateTime _createTime;
  String _color;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _usrIDController = TextEditingController();
  TextEditingController _usrPWController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();
  FocusNode nodeFour = FocusNode();

  Future<void> addMemoFirebaseDoc() async {
    final encryptTitle = await e2ee.encryptE2EE(_titleController.text);
    final encryptUsrID = await e2ee.encryptE2EE(_usrIDController.text);
    final encryptUsrPW = await e2ee.encryptE2EE(_usrPWController.text);
    final encryptText = (_textController.text == '')
        ? null
        : (_textController.text == ' ')
            ? null
            : await e2ee.encryptE2EE(_textController.text);

    _createTime = DateTime.now();
    String dateFormat = DateFormat('MM.dd').format(_createTime);

    _fireStore.collection(widget.logInUsr).add({
      'id': _createTime.toString(),
      'title': encryptTitle,
      'usrID': encryptUsrID,
      'usrPW': encryptUsrPW,
      'text': encryptText,
      'createTime': dateFormat,
      'color': _color,
    });
  }

  void showAdMob() {
    AdMobService().myInterstitialAd
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _usrIDController.dispose();
    _usrPWController.dispose();
    _textController.dispose();
    nodeOne.dispose();
    nodeTwo.dispose();
    nodeThree.dispose();
    nodeFour.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    kSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 30.0),
      decoration: BoxDecoration(
        color: kColorBlack,
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
          buildInputForm(),
          buildSizedBoxH20(),
          buildAddBtn(context),
        ],
      ),
    );
  }

  Container buildContainerBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kSize.width * 0.30),
      height: 4.0,
      decoration: BoxDecoration(
        color: Colors.white10,
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

  Widget buildInputForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTitleTextFormField(),
          buildSizedBoxH10(),
          buildIDTextFormField(),
          buildSizedBoxH10(),
          buildPWTextFormField(),
          buildSizedBoxH20(),
          buildMemoTextFormField(),
          buildWarningText(),
        ],
      ),
    );
  }

  TextFormField buildTitleTextFormField() {
    return TextFormField(
      focusNode: nodeOne,
      controller: _titleController,
      decoration: kTextFieldDecoration.copyWith(labelText: '사이트 이름'),
      onChanged: (String newTitle) {
        _titleController.text = newTitle;
        _color = SiteColor().findSiteColor(newTitle);
      },
      validator: (String title) {
        if (title.isEmpty) {
          return '사이트 이름을 입력해주세요.';
        }
        return null;
      },
    );
  }

  TextFormField buildIDTextFormField() {
    return TextFormField(
      focusNode: nodeTwo,
      controller: _usrIDController,
      decoration: kTextFieldDecoration.copyWith(
          labelText: '아이디', hintText: '예) ****@naver.com / 페이스북 로그인'),
      onChanged: (String newUsrID) {
        _usrIDController.text = newUsrID;
      },
      validator: (String title) {
        if (title.isEmpty) {
          return '아이디를 입력해주세요.';
        }
        return null;
      },
    );
  }

  TextFormField buildPWTextFormField() {
    return TextFormField(
      focusNode: nodeThree,
      controller: _usrPWController,
      decoration: kTextFieldDecoration.copyWith(labelText: '비밀번호'),
      onChanged: (String newUsrPW) {
        _usrPWController.text = newUsrPW;
      },
      validator: (String title) {
        if (title.isEmpty) {
          return '비밀번호를 입력해주세요.';
        }
        return null;
      },
    );
  }

  TextFormField buildMemoTextFormField() {
    return TextFormField(
        focusNode: nodeFour,
        controller: _textController,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        decoration: kTextFieldDecoration.copyWith(
          labelText: '메모',
          contentPadding:
              EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        ),
        onChanged: (String newText) async {
          _textController.text = newText;
        });
  }

  Text buildWarningText() {
    return Text(
      '* 메모는 필수 입력이 아닙니다.',
      style: TextStyle(color: Colors.redAccent),
      textAlign: TextAlign.end,
    );
  }

  Widget buildAddBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.15),
      child: RoundBtnFrame(
        title: '메모 추가',
        color: kColorBlue,
        icon: Icons.add,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            addMemoFirebaseDoc().then((onValue) {
              Navigator.pop(context);
            }).then((onValue) {
              showAdMob();
            });
            print('@@@@@@ Add New Memo @@@@@@');
          }
        },
      ),
    );
  }

  SizedBox buildSizedBoxH10() => SizedBox(height: 10.0);

  SizedBox buildSizedBoxH20() => SizedBox(height: 20.0);

  SizedBox buildSizedBoxH50() => SizedBox(height: 50.0);

  SizedBox buildBannerSpace() => SizedBox(height: 90.0);
}
