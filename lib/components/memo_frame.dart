import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutteridmemo/components/dialog_frame.dart';
import 'package:flutteridmemo/constants/constants.dart';
import 'package:flutteridmemo/pages/modify_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MemoFrame extends StatefulWidget {
  MemoFrame({
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
  _MemoFrameState createState() => _MemoFrameState();
}

class _MemoFrameState extends State<MemoFrame> {
  DialogFrame _dialog = DialogFrame();

  void deleteDataFirebaseDoc() {
    Firestore.instance
        .collection(widget.logInUsrEmail)
        .document(widget.doc)
        .delete();
  }

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
          padding: EdgeInsets.fromLTRB(
              20.0, 20.0, 20.0, widget.text == null ? 6.0 : 20.0),
          decoration: BoxDecoration(
            color: kColorGrey,
            borderRadius: BorderRadius.circular(kRadiusValue10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.03),
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(-3, 3.5), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                widget.title,
                style: GoogleFonts.notoSans(
                    textStyle: kMemoTitleTextStyle.copyWith(
                  color: widget.color != null
                      ? Color(int.parse(widget.color))
                      : Colors.white,
                )),
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                widget.usrID,
                style: GoogleFonts.notoSans(textStyle: kMemoIDPWTextStyle),
              ),
              SizedBox(
                height: 7.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.usrPW,
                    style: GoogleFonts.notoSans(textStyle: kMemoIDPWTextStyle),
                  ),
                  Text(
                    widget.text == null ? widget.createTime : '',
                    style: GoogleFonts.notoSans(
                        textStyle: TextStyle(color: kColorBlue)),
                  ),
                ],
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
                        style: GoogleFonts.notoSans(
                            textStyle: kMemoTextTextStyle.copyWith(
                          color: Colors.white60,
                        )),
                        softWrap: true,
                      ),
                    ),
                  ),
                  Text(
                    widget.text == null ? '' : widget.createTime,
                    style: GoogleFonts.notoSans(
                        textStyle: TextStyle(color: kColorBlue)),
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
                text: widget.text,
              ),
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
        _dialog.getDeleteDialog(context, '${widget.title}  삭제',
            '메모를 삭제하게 되면 사용자의 모든\n기기에서 삭제되며 복구 불가능합니다.', '삭제', '취소', () {
          deleteDataFirebaseDoc();
          Navigator.pop(context);
        }, () {
          Navigator.pop(context);
        }, _dialog.kDeleteAlertStyle).show();
      },
    );
  }
}
