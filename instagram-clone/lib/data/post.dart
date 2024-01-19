import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterinstagramclone/constants/firebase_paths.dart';

class Post {
  final String postKey;
  final String userKey;
  final String username;
  final String postImg;
  final String postUrl;
  final List<dynamic> numOfLikes;
  final String caption;
  final String lastCommentUser;
  final String lastComment;
  final DateTime lastCommentTime;
  final int numOfComments;
  final DateTime postTime;
  final DocumentReference reference;

  Post.fromMap(Map<String, dynamic> map, this.postKey, {this.reference})
      : userKey = map[KEY_USER_KEY],
        username = map[KEY_USER_NAME],
        postImg = map[KEY_POST_IMG],
        postUrl = map[KEY_POST_URL],
        caption = map[KEY_CAPTION],
        lastComment = map[KEY_LAST_COMMENT],
        lastCommentUser = map[KEY_LAST_COMMENT_USER],
        lastCommentTime = map[KEY_LAST_COMMENT_TIME] == null
            ? DateTime.now().toUtc()
            : (map[KEY_LAST_COMMENT_TIME] as Timestamp).toDate(),
        numOfLikes = map[KEY_NUM_OF_LIKES],
        numOfComments = map[KEY_NUM_OF_COMMENTS],
        postTime = (map[KEY_POST_TIME] as Timestamp).toDate();

  Post.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, snapshot.documentID,
            reference: snapshot.reference);

  static Map<String, dynamic> getMapForNewPost(String userKey, String username,
      String postImg, String postUrl, String caption) {
    Map<String, dynamic> map = Map();

    map[KEY_USER_KEY] = userKey;
    map[KEY_USER_NAME] = username;
    map[KEY_POST_IMG] = postImg;
    map[KEY_POST_URL] = postUrl;
    map[KEY_CAPTION] = caption;
    map[KEY_LAST_COMMENT] = "";
    map[KEY_LAST_COMMENT_USER] = "";
    map[KEY_LAST_COMMENT_TIME] = DateTime.now().toUtc();
    map[KEY_NUM_OF_LIKES] = [];
    map[KEY_NUM_OF_COMMENTS] = 0;
    map[KEY_POST_TIME] = DateTime.now().toUtc();

    return map;
  }
}
