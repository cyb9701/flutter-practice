import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/cryption/e2ee.dart';
import 'package:flutteridmemo/utils/site_color.dart';

class ModifyPage extends StatefulWidget {
  ModifyPage(
      {this.logInUsr, this.doc, this.title, this.usrID, this.usrPW, this.text});

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
  TextEditingController _titleController = TextEditingController();
  TextEditingController _usrIDController = TextEditingController();
  TextEditingController _usrPWController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  final Firestore _fireStore = Firestore.instance;
  E2EE e2ee = E2EE();
  FocusNode nodeOne = FocusNode();
  FocusNode nodeTwo = FocusNode();
  FocusNode nodeThree = FocusNode();
  FocusNode nodeFour = FocusNode();

  Future<void> updateMemoFirebaseDoc() async {
    final title = _titleController.text == ''
        ? await e2ee.encryptE2EE(widget.title.toString())
        : _titleController.text == ' '
            ? await e2ee.encryptE2EE(widget.title.toString())
            : await e2ee.encryptE2EE(_titleController.text.toString());
    final usrID = _usrIDController.text == ''
        ? await e2ee.encryptE2EE(widget.usrID.toString())
        : _usrIDController.text == ' '
            ? await e2ee.encryptE2EE(widget.usrID.toString())
            : await e2ee.encryptE2EE(_usrIDController.text.toString());
    final usrPW = _usrPWController.text == ''
        ? await e2ee.encryptE2EE(widget.usrPW.toString())
        : _usrPWController.text == ' '
            ? await e2ee.encryptE2EE(widget.usrPW.toString())
            : await e2ee.encryptE2EE(_usrPWController.text.toString());
    final text = _textController.text == ''
        ? await e2ee.encryptE2EE(widget.text.toString())
        : _textController.text == ' '
            ? await e2ee.encryptE2EE(widget.text.toString())
            : await e2ee.encryptE2EE(_textController.text.toString());

    _fireStore.collection(widget.logInUsr).document(widget.doc).updateData({
      'title': title,
      'usrID': usrID,
      'usrPW': usrPW,
      'text': text,
      'color': SiteColor().findSiteColor(_titleController.text == ''
          ? widget.title
          : _titleController.text.toString()),
    });
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
    );
  }

  Container buildContainerBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kSize.width * 0.35),
      height: 5.0,
      decoration: BoxDecoration(
        color: Colors.white10,
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

  TextFormField buildTitleTextField() {
    return TextFormField(
      focusNode: nodeOne,
      decoration: kTextFieldDecoration.copyWith(labelText: widget.title),
      onChanged: (String newUsrTitle) {
        _titleController.text = newUsrTitle;
      },
    );
  }

  TextFormField buildIDTextField() {
    return TextFormField(
      focusNode: nodeTwo,
      decoration: kTextFieldDecoration.copyWith(labelText: widget.usrID),
      onChanged: (String newUsrID) {
        _usrIDController.text = newUsrID;
      },
    );
  }

  TextFormField buildPWTextField() {
    return TextFormField(
      focusNode: nodeThree,
      decoration: kTextFieldDecoration.copyWith(labelText: widget.usrPW),
      onChanged: (String newUsrPW) {
        _usrPWController.text = newUsrPW;
      },
    );
  }

  TextFormField buildMemoTextField() {
    return TextFormField(
      focusNode: nodeFour,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: kTextFieldDecoration.copyWith(labelText: widget.text),
      onChanged: (String newText) {
        _textController.text = newText;
      },
    );
  }

  Text buildWarningText() {
    return Text(
      '* 원하는 부분만 수정 가능합니다.\n* 변경 취소를 원하시면 바깥 화면을 터치하세요.',
      style: TextStyle(color: Colors.redAccent),
      textAlign: TextAlign.end,
    );
  }

  Widget buildModifyBtn(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kSize.width * 0.15),
      child: RoundBtnFrame(
        title: '메모 수정',
        color: kColorBlue,
        icon: Icons.refresh,
        onPressed: () {
          print('@@@@@@ ModifyTitle: [${_titleController.text}] @@@@@@');
          print('@@@@@@ ModifyUsrID: [${_usrIDController.text}] @@@@@@');
          print('@@@@@@ ModifyUsrPW: [${_usrPWController.text}] @@@@@@');
          print('@@@@@@ ModifyText: [${_textController.text}] @@@@@@');
          updateMemoFirebaseDoc().then((onValue) {
            Navigator.pop(context);
          });
        },
      ),
    );
  }

  SizedBox buildSizedBoxH10() => SizedBox(height: 10.0);

  SizedBox buildSizedBoxH20() => SizedBox(height: 20.0);

  SizedBox buildSizedBoxH50() => SizedBox(height: 50.0);

  SizedBox buildBannerSpace() => SizedBox(height: 90.0);
}
