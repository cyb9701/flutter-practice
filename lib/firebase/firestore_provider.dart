import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterinstagramclone/constants/firebase_paths.dart';
import 'package:flutterinstagramclone/data/user.dart';

FirestoreProvider firestoreProvider = FirestoreProvider();
Firestore _firestore = Firestore.instance;

class FirestoreProvider {
  Future<void> attemptCreateUser({String userKey, String email}) {
    final DocumentReference documentRef =
        _firestore.collection(COLLECTION_USERS).document(userKey);
    return _firestore.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentRef);
      if (snapshot.exists) {
        return;
      } else {
        transaction.set(documentRef, User.getMapForCreateUser(email));
      }
    });
  }

//  Future<void> sendData() {
//    return Firestore.instance
//        .collection('Users')
//        .document('User_Key')
//        .setData({'email': 'cyb9701@naver.com', 'author': 'Author'});
//  }
//
//  void getData() {
//    Firestore.instance.collection('Users').document('User_Key').get().then(
//      (snapshot) {
//        print('@@@@@@ Document Data : ${snapshot.data}@@@@@@');
//      },
//    );
//  }
}
