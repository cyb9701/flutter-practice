import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterinstagramclone/data/user.dart';

// Transform Data, DocumentSnapshot to User.
class Transformer {
  final toUser = StreamTransformer<DocumentSnapshot, User>.fromHandlers(
    handleData: (data, sink) {
      sink.add(
        User.fromSnapshot(data),
      );
    },
  );

  final toAllUsers = StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
    handleData: (data, sink) {
      List<User> users = [];
      data.documents.forEach((doc) {
        users.add(User.fromSnapshot(doc));
      });
      sink.add(users);
    },
  );

  // Get All Users Data to User List, Except My Data.
  final toAllUsersExceptMe =
      StreamTransformer<QuerySnapshot, List<User>>.fromHandlers(
    handleData: (data, sink) async {
      List<User> users = [];
      FirebaseUser user = await FirebaseAuth.instance.currentUser();
      data.documents.forEach(
        (doc) {
          if (doc.documentID != user.uid) {
            users.add(User.fromSnapshot(doc));
          }
        },
      );
      sink.add(users);
    },
  );
}
