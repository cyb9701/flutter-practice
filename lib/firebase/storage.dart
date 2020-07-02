import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutterinstagramclone/utils/post_path.dart';

Storage storage = Storage();

class Storage {
  final FirebaseStorage _firebaseStorage = FirebaseStorage();

  Future<dynamic> uploadImg(File img, String path) async {
    final StorageReference storageReference =
        _firebaseStorage.ref().child(path);
    final StorageUploadTask storageUploadTask = storageReference.putFile(img);
    await storageUploadTask.onComplete;
    print('@@@@@@ Img Upload Complete @@@@@@');
    return storageReference.getDownloadURL();
  }

  Future<dynamic> getOnlyOnePostImgUrl(String postPath) {
    return _firebaseStorage.ref().child(getPostPath(postPath)).getDownloadURL();
  }
}
