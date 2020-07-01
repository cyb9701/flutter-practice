import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterinstagramclone/constants/firebase_paths.dart';
import 'package:flutterinstagramclone/data/user.dart';
import 'package:flutterinstagramclone/firebase/transformer.dart';

Database database = Database();
Firestore _firestore = Firestore.instance;

class Database with Transformer {
  Future<void> attemptCreateUser({String userKey, String email}) async {
    final DocumentReference documentRef =
        _firestore.collection(COLLECTION_USERS).document(userKey);
    final DocumentSnapshot snapshot = await documentRef.get();
    return _firestore.runTransaction((Transaction transaction) async {
      if (!snapshot.exists) {
        print('@@@@@@ Create User Data @@@@@@');
        return transaction.set(documentRef, User.getMapForCreateUser(email));
      }
    });
  }

  // Connecting Firestore to My Application.
  Stream<User> connectMyUserData(String userKey) {
    return _firestore
        .collection(COLLECTION_USERS)
        .document(userKey)
        .snapshots()
        .transform(toUser);
  }

  // Get All Users.
  Stream<List<User>> fetchAllUsers() {
    return _firestore
        .collection(COLLECTION_USERS)
        .snapshots()
        .transform(toAllUsers);
  }

  Stream<List<User>> fetchAllUsersExceptMe() {
    return _firestore
        .collection(COLLECTION_USERS)
        .snapshots()
        .transform(toAllUsersExceptMe);
  }

  // Create A New Post. And Confirm Post Data Exists.
  Future<Map<String, dynamic>> createNewPost(
      String postKey, Map<String, dynamic> postData) async {
    final DocumentReference postRef =
        _firestore.collection(COLLECTION_POSTS).document(postKey);
    final DocumentSnapshot postSnapshot = await postRef.get();
    final DocumentReference userRef = _firestore
        .collection(COLLECTION_USERS)
        .document(postData[KEY_USER_KEY]);
    return _firestore.runTransaction((Transaction tx) async {
      tx.update(userRef, {
        KEY_MY_POSTS: FieldValue.arrayUnion([postData])
      });
      if (!postSnapshot.exists) {
        await tx.set(postRef, postData);
      }
    });
  }
}
