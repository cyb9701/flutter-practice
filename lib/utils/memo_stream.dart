import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:flutteridmemo/components/memo_material.dart';
import 'package:flutteridmemo/database/hive_db.dart';

class MemoStream extends StatefulWidget {
  MemoStream({@required this.logInUsrEmail, @required this.search});

  final String logInUsrEmail;
  final String search;

  @override
  _MemoStreamState createState() => _MemoStreamState();
}

class _MemoStreamState extends State<MemoStream> {
  final _fireStore = Firestore.instance;
  final crypt = new PlatformStringCryptor();
  final key = HiveDB().getKey();

  Stream<List<MemoMaterial>> memosStream;

  Future<MemoMaterial> generateMemoMaterial(DocumentSnapshot memo) async {
    final memoTitle = await crypt.decrypt(memo.data['title'], key);
    final memoUsrID = await crypt.decrypt(memo.data['usrID'], key);
    final memoUsrPW = await crypt.decrypt(memo.data['usrPW'], key);
    final memoText = await crypt.decrypt(memo.data['title'], key);

    return MemoMaterial(
      logInUsrEmail: widget.logInUsrEmail,
      doc: memo.documentID,
      title: memoTitle,
      usrID: memoUsrID,
      usrPW: memoUsrPW,
      text: memoText,
      createTime: memo.data['createTime'],
    );
  }

  @override
  void initState() {
    memosStream = _fireStore
        .collection(widget.logInUsrEmail)
        .orderBy('id', descending: false)
        .snapshots()
        .asyncMap((documents) {
      print('@@@@@@ ${documents.documents[1]} @@@@@@');
      return Future.wait(
          [for (var memo in documents.documents) generateMemoMaterial(memo)]);
    });
    print('@@@@@@ Key:${HiveDB().getKey()} @@@@@@');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MemoMaterial>>(
      stream: memosStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        final memoList = snapshot.data;
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
