import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterinstagramclone/constants/firebase_paths.dart';

class User {
  final String userKey;
  final String userName;
  final String profileImg;
  final String email;
  final int followers;
  final List<dynamic> followings;
  final List<dynamic> myPosts;
  final List<dynamic> likePosts;
  final DocumentReference reference;

  // User makes Map.
  User.fromMap(Map<String, dynamic> map, this.userKey, {this.reference})
      : userName = map[KEY_USER_NAME],
        profileImg = map[KEY_PROFILE_IMG],
        email = map[KEY_EMAIL],
        followers = map[KEY_FOLLOWERS],
        followings = map[KEY_FOLLOWINGS],
        myPosts = map[KEY_MY_POSTS],
        likePosts = map[KEY_LIKED_POSTS];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data,
          snapshot.documentID,
          reference: snapshot.reference,
        );

  // Get Map for First Create User.
  static Map<String, dynamic> getMapForCreateUser(String email) {
    Map<String, dynamic> map = Map();
    map[KEY_USER_NAME] = email.split('@')[0];
    map[KEY_PROFILE_IMG] = '';
    map[KEY_EMAIL] = email;
    map[KEY_FOLLOWERS] = 0;
    map[KEY_FOLLOWINGS] = [];
    map[KEY_MY_POSTS] = [];
    map[KEY_LIKED_POSTS] = [];
    return map;
  }
}
