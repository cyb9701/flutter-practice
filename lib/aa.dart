//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:flutteridmemomemo/components/memo_material.dart';
//
//class MemoStream extends StatefulWidget {
//  MemoStream({@required this.logInUsrEmail, @required this.search});
//
//  final String logInUsrEmail;
//  final String search;
//
//  @override
//  _MemoStreamState createState() => _MemoStreamState();
//}
//
//class _MemoStreamState extends State<MemoStream> {
//  final _fireStore = Firestore.instance;
//
//  Stream<QuerySnapshot> get _stream {
//    return _fireStore
//        .collection(widget.logInUsrEmail)
//        .orderBy('id', descending: false)
//        .snapshots();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: _stream,
//      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//        if (!snapshot.hasData) return LinearProgressIndicator();
//
//        final memos = snapshot.data.documents;
//        List<MemoMaterial> memoList = [];
//
//        for (var memo in memos) {
//          final memoDocumentID = memo.documentID;
//          final memoTitle = memo.data['title'];
//          final memoUsrID = memo.data['usrID'];
//          final memoUsrPW = memo.data['usrPW'];
//          final memoText = memo.data['text'];
//          final memoCreateTime = memo.data['createTime'];
//
//          final memoMaterial = MemoMaterial(
//            logInUsrEmail: widget.logInUsrEmail,
//            doc: memoDocumentID,
//            title: memoTitle,
//            usrID: memoUsrID,
//            usrPW: memoUsrPW,
//            text: memoText,
//            createTime: memoCreateTime,
//          );
//          memoList.add(memoMaterial);
//        }
//
//        return Expanded(
//          child: new ListView.builder(
//              itemCount: memoList.length,
//              itemBuilder: (context, index) {
//                return widget.search == null || widget.search == ''
//                    ? memoList[index]
//                    : '${memoList[index].title}'
//                            .toLowerCase()
//                            .contains(widget.search.toLowerCase())
//                        ? memoList[index]
//                        : '${memoList[index].usrID}'
//                                .toLowerCase()
//                                .contains(widget.search.toLowerCase())
//                            ? memoList[index]
//                            : '${memoList[index].usrPW}'
//                                    .toLowerCase()
//                                    .contains(widget.search.toLowerCase())
//                                ? memoList[index]
//                                : '${memoList[index].text}'
//                                        .toLowerCase()
//                                        .contains(widget.search.toLowerCase())
//                                    ? memoList[index]
//                                    : new Container();
//              }),
//        );
//      },
//    );
//  }
//}
