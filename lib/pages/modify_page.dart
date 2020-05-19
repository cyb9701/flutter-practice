import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/cryption/e2ee.dart';
import 'package:flutteridmemo/utils/site_color.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final Firestore _fireStore = Firestore.instance;
  E2EE e2ee = E2EE();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _usrIDController = TextEditingController();
  TextEditingController _usrPWController = TextEditingController();
  TextEditingController _textController = TextEditingController();
  FocusNode titleFocusNode;
  FocusNode idFocusNode;
  FocusNode pwFocusNode;
  FocusNode textFocusNode;

  void _buildFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

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
  void initState() {
    titleFocusNode = FocusNode();
    idFocusNode = FocusNode();
    pwFocusNode = FocusNode();
    textFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _usrIDController.dispose();
    _usrPWController.dispose();
    _textController.dispose();
    titleFocusNode.dispose();
    idFocusNode.dispose();
    pwFocusNode.dispose();
    textFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    kSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 30.0),
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
          SizedBox(height: 20.0),
          buildTitle(),
          SizedBox(height: 50.0),
          buildInputForm(),
          buildWarningText(),
          SizedBox(height: 20.0),
          buildBtn(context),
        ],
      ),
    );
  }

  Container buildContainerBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kSize.width * 0.30),
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
      style: GoogleFonts.jua(textStyle: kAddPageTitleTextStyle),
    );
  }

  Widget buildInputForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildTitleTextField(),
          SizedBox(height: 10.0),
          buildIDTextField(),
          SizedBox(height: 10.0),
          buildPWTextField(),
          SizedBox(height: 20.0),
          buildMemoTextField(),
        ],
      ),
    );
  }

  TextFormField buildTitleTextField() {
    return TextFormField(
      focusNode: titleFocusNode,
      controller: _titleController,
      onFieldSubmitted: (value) {
        _buildFocusChange(_formKey.currentContext, titleFocusNode, idFocusNode);
      },
      textInputAction: TextInputAction.next,
      decoration: kBlueTextFieldDecoration.copyWith(labelText: widget.title),
    );
  }

  TextFormField buildIDTextField() {
    return TextFormField(
      focusNode: idFocusNode,
      controller: _usrIDController,
      onFieldSubmitted: (value) {
        _buildFocusChange(_formKey.currentContext, idFocusNode, pwFocusNode);
      },
      textInputAction: TextInputAction.next,
      decoration: kBlueTextFieldDecoration.copyWith(labelText: widget.usrID),
    );
  }

  TextFormField buildPWTextField() {
    return TextFormField(
      focusNode: pwFocusNode,
      controller: _usrPWController,
      onFieldSubmitted: (value) {
        _buildFocusChange(_formKey.currentContext, pwFocusNode, textFocusNode);
      },
      textInputAction: TextInputAction.next,
      decoration: kBlueTextFieldDecoration.copyWith(labelText: widget.usrPW),
    );
  }

  TextFormField buildMemoTextField() {
    return TextFormField(
      focusNode: textFocusNode,
      controller: _textController,
      onFieldSubmitted: (value) {
        textFocusNode.unfocus();
      },
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: kBlueTextFieldDecoration.copyWith(labelText: widget.text),
    );
  }

  Text buildWarningText() {
    return Text(
      '* 원하는 부분만 수정 가능합니다.\n* 변경 취소를 원하시면 바깥 화면을 터치하세요.',
      style: TextStyle(color: Colors.redAccent),
      textAlign: TextAlign.end,
    );
  }

  Widget buildBtn(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RoundBtnFrame(
            title: '취소',
            color: kColorGrey,
            textColor: Colors.white70,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(width: 20.0),
        Expanded(
          child: RoundBtnFrame(
            title: '메모 수정',
            color: kColorBlue,
            textColor: kColorGrey,
            onPressed: () {
              updateMemoFirebaseDoc().whenComplete(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
      ],
    );
  }
}
