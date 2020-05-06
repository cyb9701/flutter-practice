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

  String _modifyTitle;
  String _modifyUsrID;
  String _modifyUsrPW;
  String _modifyText;
  String _modifyColor;

  void getData() {
    _modifyTitle = widget.title;
    _modifyUsrID = widget.usrID;
    _modifyUsrPW = widget.usrPW;
    _modifyText = widget.text;
  }

  Future<void> updateMemoFirebaseDoc(String modifyTitle, String modifyUsrID,
      String modifyUsrPW, String modifyText, String modifyColor) async {
    final title = modifyTitle == ''
        ? await e2ee.encryptE2EE(widget.title)
        : modifyTitle == ' '
            ? await e2ee.encryptE2EE(widget.title)
            : await e2ee.encryptE2EE(modifyTitle);

    final usrID = modifyUsrID == ''
        ? await e2ee.encryptE2EE(widget.usrID)
        : modifyUsrID == ' '
            ? await e2ee.encryptE2EE(widget.usrID)
            : await e2ee.encryptE2EE(modifyUsrID);

    final usrPW = modifyUsrPW == ''
        ? await e2ee.encryptE2EE(widget.usrPW)
        : modifyUsrPW == ' '
            ? await e2ee.encryptE2EE(widget.usrPW)
            : await e2ee.encryptE2EE(modifyUsrPW);

    final text = modifyText == '' ? null : await e2ee.encryptE2EE(modifyText);

    _fireStore.collection(widget.logInUsr).document(widget.doc).updateData({
      'title': title,
      'usrID': usrID,
      'usrPW': usrPW,
      'text': text,
      'color': modifyColor,
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _usrIDController.dispose();
    _usrPWController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    kSize = MediaQuery.of(context).size;

    return Container(
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

  TextFormField buildTitleTextField() {
    return TextFormField(
      focusNode: nodeOne,
      controller: _titleController..text = widget.title,
      decoration: kTextFieldDecoration.copyWith(
        suffixIcon: InkWell(
          onTap: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _titleController.clear());
          },
          child: Icon(
            Icons.cancel,
            color: kColorGreen,
          ),
        ),
      ),
      onChanged: (String newUsrTitle) {
        _modifyTitle = newUsrTitle;
        _modifyColor = SiteColor().findSiteColor(newUsrTitle);
      },
    );
  }

  TextFormField buildIDTextField() {
    return TextFormField(
      focusNode: nodeTwo,
      controller: _usrIDController..text = widget.usrID,
      decoration: kTextFieldDecoration.copyWith(
        suffixIcon: InkWell(
          onTap: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _usrIDController.clear());
          },
          child: Icon(
            Icons.cancel,
            color: kColorGreen,
          ),
        ),
      ),
      onChanged: (String newUsrID) {
        _modifyUsrID = newUsrID;
      },
    );
  }

  TextFormField buildPWTextField() {
    return TextFormField(
      focusNode: nodeThree,
      controller: _usrPWController..text = widget.usrPW,
      decoration: kTextFieldDecoration.copyWith(
        suffixIcon: InkWell(
          onTap: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _usrPWController.clear());
          },
          child: Icon(
            Icons.cancel,
            color: kColorGreen,
          ),
        ),
      ),
      onChanged: (String newUsrPW) {
//        final encryptUsrPW = await e2ee.encryptE2EE(newUsrPW, _key);
        _modifyUsrPW = newUsrPW;
      },
    );
  }

  TextFormField buildMemoTextField() {
    return TextFormField(
      focusNode: nodeFour,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      controller: _textController..text = widget.text,
      decoration: kTextFieldDecoration.copyWith(
        suffixIcon: InkWell(
          onTap: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _textController.clear());
            _modifyText = '';
          },
          child: Icon(
            Icons.cancel,
            color: kColorGreen,
          ),
        ),
      ),
      onChanged: (String newText) {
//        final encryptText = await e2ee.encryptE2EE(newText, _key);
        _modifyText = newText;
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
          print('@@@@@@ ModifyTitle: $_modifyTitle @@@@@@');
          print('@@@@@@ ModifyID: $_modifyUsrID @@@@@@');
          print('@@@@@@ ModifyPW: $_modifyUsrPW @@@@@@');
          print('@@@@@@ ModifyText: $_modifyText @@@@@@');
          updateMemoFirebaseDoc(_modifyTitle, _modifyUsrID, _modifyUsrPW,
              _modifyText, _modifyColor);
          Navigator.pop(context);
        },
      ),
    );
  }

  SizedBox buildSizedBoxH10() => SizedBox(height: 10.0);

  SizedBox buildSizedBoxH20() => SizedBox(height: 20.0);

  SizedBox buildSizedBoxH50() => SizedBox(height: 50.0);

  SizedBox buildBannerSpace() => SizedBox(height: 90.0);
}
