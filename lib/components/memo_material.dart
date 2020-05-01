import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/pages/modify_page.dart';

class MemoMaterial extends StatefulWidget {
  MemoMaterial({
    this.logInUsrEmail,
    this.doc,
    this.title,
    this.usrID,
    this.usrPW,
    this.text,
    this.createTime,
    this.color,
  });

  final String logInUsrEmail;
  final String doc;
  final String title;
  final String usrID;
  final String usrPW;
  final String text;
  final String createTime;
  final String color;

  @override
  _MemoMaterialState createState() => _MemoMaterialState();
}

class _MemoMaterialState extends State<MemoMaterial> {
//  String _logInUsrEmail = 'Loading';
//  String _doc = 'Loading';
//  String _title = 'Loading';
//  String _usrID = 'Loading';
//  String _usrPW = 'Loading';
//  String _text = 'Loading';
//  String _createTime = 'Loading';
//
//  void getData() {
//    setState(() {
//      _logInUsrEmail = widget.logInUsrEmail;
//      _doc = widget.doc;
//      _title = widget.title;
//      _usrID = widget.usrID;
//      _usrPW = widget.usrPW;
//      _text = widget.text;
//      _createTime = widget.createTime;
//    });
//  }

  void deleteDataFirebaseDoc() {
    Firestore.instance
        .collection(widget.logInUsrEmail)
        .document(widget.doc)
        .delete();
  }

//  @override
//  void initState() {
//    getData();
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(30, 10, 20, 10),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.18,
        secondaryActions: <Widget>[
          buildModifyBtn(context),
          buildDeleteBtn(context),
        ],
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: kColorGrey,
            border: Border.all(
                color: widget.color != null
                    ? Color(int.parse(widget.color))
                    : kColorGrey,
                width: 1.0),
            borderRadius: BorderRadius.circular(kRadiusValue20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                widget.title,
                style: kMemoTitleTextStyle,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                widget.usrID,
                style: kMemoIDPWTextStyle,
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                widget.usrPW,
                style: kMemoIDPWTextStyle,
              ),
              SizedBox(
                height: widget.text == null ? 0.0 : 7.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text(
                        widget.text == null ? '' : widget.text,
                        style: kMemoTextTextStyle,
                        softWrap: true,
                      ),
                    ),
                  ),
                  Text(
                    widget.createTime,
                    style: TextStyle(color: kColorBlue),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconSlideAction buildModifyBtn(BuildContext context) {
    return IconSlideAction(
      caption: '수정',
      color: Colors.blueAccent,
      icon: Icons.autorenew,
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ModifyPage(
                  logInUsr: widget.logInUsrEmail,
                  doc: widget.doc,
                  title: widget.title,
                  usrID: widget.usrID,
                  usrPW: widget.usrPW,
                  text: widget.text == null ? null : widget.text),
            ),
          ),
        );
      },
    );
  }

  IconSlideAction buildDeleteBtn(BuildContext context) {
    return IconSlideAction(
      caption: '삭제',
      color: Colors.redAccent,
      icon: Icons.cancel,
      onTap: () {
        final actionSheet = new CupertinoAlertDialog(
          title: new Text("삭제"),
          content: new Text(
              "${widget.title} 메모를 정말로 삭제하시겠습니까?\n사용자의 모든 기기에서 삭제되면 복구 불가능합니다."),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                deleteDataFirebaseDoc();
                Navigator.pop(context);
              },
              child: Text("삭제"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("취소"),
            )
          ],
        );

        showCupertinoModalPopup(
            context: context, builder: (BuildContext context) => actionSheet);
      },
    );
  }
}
