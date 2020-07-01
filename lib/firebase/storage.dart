import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterinstagramclone/utils/post_path.dart';

Storage storage = Storage();

class Storage {
  final FirebaseStorage _firebaseStorage = FirebaseStorage();

  Future<StorageTaskSnapshot> uploadImg(File img, String path) {
    final StorageReference storageReference =
        _firebaseStorage.ref().child(path);
    final StorageUploadTask storageUploadTask = storageReference.putFile(img);
    print('@@@@@@ Img Upload Complete @@@@@@');
    return storageUploadTask.onComplete;
  }

  Future<dynamic> getPostImgUrl(String postPath) {
    return _firebaseStorage.ref().child(getPostPath(postPath)).getDownloadURL();
  }
}
