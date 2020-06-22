import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterinstagramclone/data/user.dart';

class Transformer {
  final toUser = StreamTransformer<DocumentSnapshot, User>.fromHandlers(
    handleData: (data, sink) {
      sink.add(
        User.fromSnapshot(data),
      );
    },
  );
}
