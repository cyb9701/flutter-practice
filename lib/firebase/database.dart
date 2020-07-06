import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterinstagramclone/constants/firebase_paths.dart';
import 'package:flutterinstagramclone/data/comment.dart';
import 'package:flutterinstagramclone/data/post.dart';
import 'package:flutterinstagramclone/data/user.dart';
import 'package:flutterinstagramclone/firebase/transformer.dart';
import 'package:rxdart/rxdart.dart';

Database database = Database();
Firestore _firestore = Firestore.instance;

class Database with Transformer {
  //Create User Data That First Sign Up User.
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

  //Connecting Firestore to My Application.
  Stream<User> connectMyUserData(String userKey) {
    return _firestore
        .collection(COLLECTION_USERS)
        .document(userKey)
        .snapshots()
        .transform(toUser);
  }

  //Get All Users.
  Stream<List<User>> fetchAllUsers() {
    return _firestore
        .collection(COLLECTION_USERS)
        .snapshots()
        .transform(toAllUsers);
  }

  //Get All Users Except Me.
  Stream<List<User>> fetchAllUsersExceptMe() {
    return _firestore
        .collection(COLLECTION_USERS)
        .snapshots()
        .transform(toAllUsersExceptMe);
  }

  //Follow User.
  Future<Map<String, dynamic>> followUser(
      String myUserKey, String otherUserKey) async {
    //my doc ref&snapshot
    final DocumentReference myUserRef =
        _firestore.collection(COLLECTION_USERS).document(myUserKey);
    DocumentSnapshot myUserSnapshot = await myUserRef.get();

    //other doc ref&snapshot
    final DocumentReference otherUserRef =
        _firestore.collection(COLLECTION_USERS).document(otherUserKey);
    DocumentSnapshot otherUserSnapshot = await otherUserRef.get();

    //run transaction
    return _firestore.runTransaction(
      (Transaction tx) async {
        if (myUserSnapshot.exists && otherUserSnapshot.exists) {
          await tx.update(myUserRef, <String, dynamic>{
            KEY_FOLLOWINGS: FieldValue.arrayUnion([otherUserKey])
          });

          int currentFollowers = otherUserSnapshot.data[KEY_FOLLOWERS];
          await tx.update(otherUserRef,
              <String, dynamic>{KEY_FOLLOWERS: currentFollowers + 1});

          print(
              '@@@@@@ Complete ${otherUserSnapshot.data[KEY_USER_NAME]} Follow @@@@@@');
        }
      },
    );
  }

  // UnFollow User.
  Future<Map<String, dynamic>> unFollowUser(
      String myUserKey, String otherUserKey) async {
    //my doc ref&snapshot
    final DocumentReference myUserRef =
        _firestore.collection(COLLECTION_USERS).document(myUserKey);
    DocumentSnapshot myUserSnapshot = await myUserRef.get();

    //other doc ref&snapshot
    final DocumentReference otherUserRef =
        _firestore.collection(COLLECTION_USERS).document(otherUserKey);
    DocumentSnapshot otherUserSnapshot = await otherUserRef.get();

    //run transaction
    return _firestore.runTransaction(
      (Transaction tx) async {
        if (myUserSnapshot.exists && otherUserSnapshot.exists) {
          await tx.update(myUserRef, <String, dynamic>{
            KEY_FOLLOWINGS: FieldValue.arrayRemove([otherUserKey])
          });

          int currentFollowers = otherUserSnapshot.data[KEY_FOLLOWERS];
          await tx.update(otherUserRef,
              <String, dynamic>{KEY_FOLLOWERS: currentFollowers - 1});

          print(
              '@@@@@@ Complete ${otherUserSnapshot.data[KEY_USER_NAME]} UnFollow @@@@@@');
        }
      },
    );
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
        KEY_MY_POSTS: FieldValue.arrayUnion([postKey])
      });

      if (!postSnapshot.exists) {
        await tx.set(postRef, postData);
      }
    });
  }

  Stream<List<Post>> fetchAllPostsFromFollowing(
      List<dynamic> following, String userKey) {
    final CollectionReference postRef = _firestore.collection(COLLECTION_POSTS);
    List<Stream<List<Post>>> streams = [];
    for (int i = 0; i < following.length; i++) {
      streams.add(postRef
          .where(KEY_USER_KEY, isEqualTo: following[i])
          .snapshots()
          .transform(toPosts));
    }
    streams.add(postRef
        .where(KEY_USER_KEY, isEqualTo: userKey)
        .snapshots()
        .transform(toPosts));

    //listOfPost = List<List<Post>>
    return CombineLatestStream(streams, (listOfPost) {
      List<Post> combinedPost = [];
      for (List<Post> posts in listOfPost) {
        combinedPost.addAll(posts);
      }
      return combinedPost;
    });
  }

  //Fetch Posts Only My Posts.
  Stream<List<Post>> fetchAllMyPosts(String userKey) {
    return _firestore
        .collection(COLLECTION_POSTS)
        .where(KEY_USER_KEY, isEqualTo: userKey)
        .snapshots()
        .transform(toPosts);
  }

  Future<Map<String, dynamic>> createNewComment(
      Map<String, dynamic> commentData, String postKey) async {
    final DocumentReference postRef =
        _firestore.collection(COLLECTION_POSTS).document(postKey);
    final DocumentSnapshot snapshot = await postRef.get();
    final DocumentReference commentRef =
        postRef.collection(COLLECTION_COMMENTS).document();

    return _firestore.runTransaction(
      (Transaction tx) async {
        await tx.set(commentRef, commentData);

        int numOfComment = snapshot.data[KEY_NUM_OF_COMMENTS];
        await tx.update(
          postRef,
          {
            KEY_LAST_COMMENT: commentData[KEY_COMMENT],
            KEY_LAST_COMMENT_USER: commentData[KEY_USER_NAME],
            KEY_LAST_COMMENT_TIME: commentData[KEY_COMMENT_TIME],
            KEY_NUM_OF_COMMENTS: numOfComment + 1,
          },
        );
      },
    );
  }

  Stream<List<Comment>> fetchAllComments(String postKey) {
    return _firestore
        .collection(COLLECTION_POSTS)
        .document(postKey)
        .collection(COLLECTION_COMMENTS)
        .orderBy(KEY_COMMENT_TIME)
        .snapshots()
        .transform(toComments);
  }

  Future<void> toggleLike(String userKey, String postKey) async {
    final DocumentReference postRef =
        _firestore.collection(COLLECTION_POSTS).document(postKey);
    final DocumentSnapshot snapshot = await postRef.get();
    if (snapshot.exists) {
      if (snapshot.data[KEY_NUM_OF_LIKES].contains(userKey)) {
        print('@@@@@@ Complete UnLike @@@@@@');
        postRef.updateData(
          {
            KEY_NUM_OF_LIKES: FieldValue.arrayRemove([userKey])
          },
        );
      } else {
        print('@@@@@@ Complete Like @@@@@@');
        postRef.updateData(
          {
            KEY_NUM_OF_LIKES: FieldValue.arrayUnion([userKey])
          },
        );
      }
    }
  }
}
