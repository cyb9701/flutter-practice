import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/round_button.dart';
import 'package:flutteridmemo/constants/constants.dart';

class ModifyPage extends StatefulWidget {
  ModifyPage(
      {@required this.logInUsr,
      @required this.doc,
      @required this.title,
      @required this.usrID,
      @required this.usrPW,
      @required this.text});

  final String logInUsr;
  final String doc;
  final String title;
  final String usrID;
  final String usrPW;
  final String text;

  @override
  _ModifyPageState createState() => _ModifyPageState();
}

class _ModifyPageState extends State<ModifyPage> {
  final Firestore _fireStore = Firestore.instance;
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();
  FocusNode nodeFour = FocusNode();

  String _modifyTitle;
  String _modifyUsrID;
  String _modifyUsrPW;
  String _modifyText;

  void getData() {
    setState(() {
      _modifyTitle = widget.title;
      _modifyUsrID = widget.usrID;
      _modifyUsrPW = widget.usrPW;
      _modifyText = widget.text;
    });
  }

  void updateMemoFirebaseDoc(String modifyTitle, String modifyUsrID,
      String modifyUsrPW, String modifyText) {
    _fireStore.collection(widget.logInUsr).document(widget.doc).updateData({
      'title': modifyTitle,
      'usrID': modifyUsrID,
      'usrPW': modifyUsrPW,
      'text': modifyText,
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
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
            buildSizedBoxH20(),
            buildMemoTextField(),
            buildWarningText(),
            buildSizedBoxH20(),
            buildModifyBtn(context),
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
      '메모 수정',
      textAlign: TextAlign.center,
      style: kAddPageTitleTextStyle.copyWith(fontWeight: FontWeight.bold),
    );
  }

  TextField buildTitleTextField() {
    return TextField(
      focusNode: nodeOne,
      controller: TextEditingController(),
      decoration: kTextFieldDecoration.copyWith(labelText: _modifyTitle),
      onChanged: (String newUsrTitle) {
        _modifyTitle = newUsrTitle;
      },
    );
  }

  TextField buildIDTextField() {
    return TextField(
      focusNode: nodeTwo,
      controller: TextEditingController(),
      decoration: kTextFieldDecoration.copyWith(labelText: _modifyUsrID),
      onChanged: (String newUsrID) {
        _modifyUsrID = newUsrID;
      },
    );
  }

  TextField buildPWTextField() {
    return TextField(
      focusNode: nodeThree,
      controller: TextEditingController(),
      decoration: kTextFieldDecoration.copyWith(labelText: _modifyUsrPW),
      onChanged: (String newUsrPW) {
        _modifyUsrPW = newUsrPW;
      },
    );
  }

  TextField buildMemoTextField() {
    return TextField(
      focusNode: nodeFour,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      controller: TextEditingController(),
      decoration: kTextFieldDecoration.copyWith(
        labelText: _modifyText == null ? '메모' : _modifyText,
        contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      ),
      onChanged: (String newText) {
        _modifyText = newText;
      },
    );
  }

  Text buildWarningText() {
    return Text(
      '* 원하는 부분만 수정 가능합니다.',
      style: TextStyle(color: Colors.redAccent),
      textAlign: TextAlign.end,
    );
  }

  Widget buildModifyBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.2),
      child: RoundButton(
        title: '수정',
        onPressed: () {
          print('@@@@@@ ModifyTitle: $_modifyTitle @@@@@@');
          print('@@@@@@ ModifyID: $_modifyUsrID @@@@@@');
          print('@@@@@@ ModifyPW: $_modifyUsrPW @@@@@@');
          print('@@@@@@ ModifyText: $_modifyText @@@@@@');
          updateMemoFirebaseDoc(
              _modifyTitle, _modifyUsrID, _modifyUsrPW, _modifyText);
          Navigator.pop(context);
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
