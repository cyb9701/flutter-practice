import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutteridmemo/components/memo_frame.dart';
import 'package:flutteridmemo/cryption/e2ee.dart';
import 'package:flutteridmemo/database/hive_db.dart';

class MemoStream extends StatefulWidget {
  MemoStream({@required this.userEmail, this.search});

  final String userEmail;
  final String search;

  @override
  _MemoStreamState createState() => _MemoStreamState();
}

class _MemoStreamState extends State<MemoStream> {
  final _fireStore = Firestore.instance;
  final crypt = new PlatformStringCryptor();
  final key = HiveDB().getKey();
  E2EE e2ee = E2EE();

  Stream<List<MemoFrame>> memosStream;

  Future<MemoFrame> generateMemoMaterial(DocumentSnapshot memo) async {
    final memoTitle = await e2ee.decryptE22EE(memo.data['title']);
    final memoUsrID = await e2ee.decryptE22EE(memo.data['usrID']);
    final memoUsrPW = await e2ee.decryptE22EE(memo.data['usrPW']);
    final memoText = (memo.data['text'] == null)
        ? null
        : await e2ee.decryptE22EE(memo.data['text']);

    return MemoFrame(
      logInUsrEmail: widget.userEmail,
      doc: memo.documentID,
      title: memoTitle,
      usrID: memoUsrID,
      usrPW: memoUsrPW,
      text: memoText,
      createTime: memo.data['createTime'],
      color: memo.data['color'],
    );
  }

  @override
  void initState() {
    super.initState();
    print('@@@@@@ Key: $key @@@@@@');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MemoFrame>>(
      stream: memosStream = _fireStore
          .collection(widget.userEmail)
          .orderBy('id', descending: false)
          .snapshots()
          .asyncMap((data) => Future.wait(
              [for (var memo in data.documents) generateMemoMaterial(memo)])),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        final memoList = snapshot.data;
        print('@@@@@@ Memo Counter: ${snapshot.data.length} @@@@@@');
        print('@@@@@@ LogInUsr: ${widget.userEmail} @@@@@@');
        return Expanded(
          child: new ListView.builder(
              itemCount: memoList.length,
              itemBuilder: (context, index) {
                return widget.search == null || widget.search == ''
                    ? memoList[index]
                    : '${memoList[index].title}'
                            .toLowerCase()
                            .contains(widget.search.toLowerCase())
                        ? memoList[index]
                        : '${memoList[index].usrID}'
                                .toLowerCase()
                                .contains(widget.search.toLowerCase())
                            ? memoList[index]
                            : '${memoList[index].usrPW}'
                                    .toLowerCase()
                                    .contains(widget.search.toLowerCase())
                                ? memoList[index]
                                : '${memoList[index].text}'
                                        .toLowerCase()
                                        .contains(widget.search.toLowerCase())
                                    ? memoList[index]
                                    : new Container();
              }),
        );
      },
    );
  }
}
