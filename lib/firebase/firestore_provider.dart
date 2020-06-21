import 'package:cloud_firestore/cloud_firestore.dart';

FirestoreProvider firestoreProvider = FirestoreProvider();

class FirestoreProvider {
  Future<void> sendData() {
    return Firestore.instance
        .collection('Users')
        .document('User_Key')
        .setData({'email': 'cyb9701@naver.com', 'author': 'Author'});
  }

  void getData() {
    Firestore.instance.collection('Users').document('User_Key').get().then(
      (snapshot) {
        print('@@@@@@ Document Data : ${snapshot.data}@@@@@@');
      },
    );
  }
}
