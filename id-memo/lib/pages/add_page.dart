import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutteridmemo/components/round_btn_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/cryption/e2ee.dart';
import 'package:flutteridmemo/utils/site_color.dart';
import 'package:google_fonts/google_fonts.dart';
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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  Future<void> addMemoFirebaseDoc() async {
    final encryptTitle = await e2ee.encryptE2EE(_titleController.text);
    final encryptUsrID = await e2ee.encryptE2EE(_usrIDController.text);
    final encryptUsrPW = await e2ee.encryptE2EE(_usrPWController.text);
    final encryptText = (_textController.text == '')
        ? null
        : (_textController.text == ' ')
            ? null
            : await e2ee.encryptE2EE(_textController.text);
    final color = SiteColor().findSiteColor(_titleController.text);
    final createTime = DateTime.now();
    String dateFormat = DateFormat('MM.dd').format(createTime);

    _fireStore.collection(widget.logInUsr).add({
      'id': createTime.toString(),
      'title': encryptTitle,
      'usrID': encryptUsrID,
      'usrPW': encryptUsrPW,
      'text': encryptText,
      'createTime': dateFormat,
      'color': color,
    });
  }

//  void showAdMob() {
//    AdMobService().myInterstitialAd
//      ..load()
//      ..show(
//        anchorType: AnchorType.bottom,
//        anchorOffset: 0.0,
//        horizontalCenterOffset: 0.0,
//      );
//  }

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
      '메모 추가',
      textAlign: TextAlign.center,
      style: GoogleFonts.jua(textStyle: kAddPageTitleTextStyle),
    );
  }

  Widget buildInputForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTitleTextFormField(),
          SizedBox(height: 10.0),
          buildIDTextFormField(),
          SizedBox(height: 10.0),
          buildPWTextFormField(),
          SizedBox(height: 20.0),
          buildMemoTextFormField(),
        ],
      ),
    );
  }

  TextFormField buildTitleTextFormField() {
    return TextFormField(
      focusNode: titleFocusNode,
      controller: _titleController,
      textInputAction: TextInputAction.next,
      decoration: kTextFieldDecoration.copyWith(labelText: '사이트 이름'),
      onFieldSubmitted: (value) {
        _buildFocusChange(_formKey.currentContext, titleFocusNode, idFocusNode);
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
      focusNode: idFocusNode,
      controller: _usrIDController,
      textInputAction: TextInputAction.next,
      decoration: kTextFieldDecoration.copyWith(
          labelText: '아이디', hintText: '예) ****@naver.com / 페이스북 로그인'),
      onFieldSubmitted: (value) {
        _buildFocusChange(_formKey.currentContext, idFocusNode, pwFocusNode);
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
      focusNode: pwFocusNode,
      controller: _usrPWController,
      textInputAction: TextInputAction.next,
      decoration: kTextFieldDecoration.copyWith(labelText: '비밀번호'),
      onFieldSubmitted: (value) {
        _buildFocusChange(_formKey.currentContext, pwFocusNode, textFocusNode);
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
      focusNode: textFocusNode,
      controller: _textController,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: kTextFieldDecoration.copyWith(
        labelText: '메모',
        contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
      ),
      onFieldSubmitted: (value) {
        textFocusNode.unfocus();
      },
    );
  }

  Text buildWarningText() {
    return Text(
      '* 메모는 필수 입력이 아닙니다.',
      style: TextStyle(color: Colors.redAccent),
      textAlign: TextAlign.end,
    );
  }

  Widget buildBtn(BuildContext context) {
    return Row(
      children: <Widget>[
        buildCancelBtn(context),
        SizedBox(width: 20.0),
        buildAddBtn(context),
      ],
    );
  }

  Expanded buildCancelBtn(BuildContext context) {
    return Expanded(
      child: RoundBtnFrame(
        title: '취소',
        color: kColorGrey,
        textColor: Colors.white70,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget buildAddBtn(BuildContext context) {
    return Expanded(
      child: RoundBtnFrame(
        title: '메모 추가',
        color: kColorGreen,
        textColor: kColorGrey,
        onPressed: () {
          if (_formKey.currentState.validate()) {
            addMemoFirebaseDoc().whenComplete(() {
              Navigator.pop(context);
            });
//                    .whenComplete(() {
//              showAdMob();
//            });
            print('@@@@@@ Add New Memo @@@@@@');
          }
        },
      ),
    );
  }
}
