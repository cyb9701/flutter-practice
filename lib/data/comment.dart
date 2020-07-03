import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterinstagramclone/constants/firebase_paths.dart';

class Comment {
  final String comment;
  final String commentKey;
  final String userKey;
  final String username;
  final DateTime commentTime;
  final DocumentReference reference;

  Comment.fromMap(Map<String, dynamic> map, this.commentKey, {this.reference})
      : comment = map[KEY_COMMENT],
        userKey = map[KEY_USER_KEY],
        username = map[KEY_USER_NAME],
        commentTime = (map[KEY_COMMENT_TIME] as Timestamp).toDate();

  Comment.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID,
            reference: snapshot.reference);

  static Map<String, dynamic> getMapForNewComment(
      String userKey, String username, String comment) {
    Map<String, dynamic> map = Map();

    map[KEY_USER_KEY] = userKey;
    map[KEY_USER_NAME] = username;
    map[KEY_COMMENT] = comment;
    map[KEY_COMMENT_TIME] = DateTime.now().toUtc();

    return map;
  }
}
