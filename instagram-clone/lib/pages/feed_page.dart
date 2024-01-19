import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/post.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/firebase/database.dart';
import 'package:flutterinstagramclone/pages/comment_page.dart';
import 'package:flutterinstagramclone/widget/caption_comment_form.dart';
import 'package:flutterinstagramclone/widget/loading_widget.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatelessWidget {
  void _moveCommentPage(BuildContext context, Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CommentPage(
          post: post,
          user: Provider.of<MyUserData>(context).getUserData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Post>>.value(
      value: database.fetchAllPostsFromFollowing(
        Provider.of<MyUserData>(context).getUserData.followings,
        Provider.of<MyUserData>(context).getUserData.userKey,
      ),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: buildAppBar(),
        body: buildPost(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kAppBarColor,
      title: Text(
        'Instagram',
        style: TextStyle(fontSize: 35.0),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.message,
          ),
          onPressed: () {},
        )
      ],
    );
  }

  Widget buildPost() {
    return Consumer<List<Post>>(
      builder: (context, postList, child) {
        return ListView.builder(
          itemCount: postList == null ? 0 : postList.length,
          itemBuilder: (context, index) {
            postList.sort((a, b) => b.postTime.compareTo(a.postTime));
            return postItem(postList[index], context);
          },
        );
      },
    );
  }

  Widget postItem(Post post, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildPostHeader(post.username),
        buildPostImg(post.postUrl,
            Provider.of<MyUserData>(context).getUserData.userKey, post),
        buildBtn(context, post,
            Provider.of<MyUserData>(context).getUserData.userKey),
        buildLikesCount(post.numOfLikes, post.numOfComments),
        postCaption(post.username, post.caption, post.postTime),
        SizedBox(height: 5.0),
        showAllComments(post.numOfComments, context, post),
        SizedBox(height: 5.0),
        lastComment(post.lastCommentUser, post.lastComment, post.numOfComments,
            post.postTime),
        Divider(color: Colors.grey[800]),
      ],
    );
  }

  ListTile buildPostHeader(String userName) {
    return ListTile(
      leading: CircleAvatar(
        radius: kPostUsrImgRadius,
        backgroundImage: AssetImage('assets/profile_Img.png'),
      ),
      title: Text(
        userName,
        style: kProfileText,
      ),
      trailing: IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
    );
  }

  // cached network image package is empty space during img loading.
  Widget buildPostImg(String postUrl, String userKey, Post post) {
    return GestureDetector(
      onDoubleTap: () {
        database.toggleLike(userKey, post.postKey);
      },
      child: CachedNetworkImage(
        imageUrl: postUrl,
        width: kSize.width,
        height: kSize.width,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return LoadingWidget(
            width: kSize.width,
            height: kSize.width,
          );
        },
      ),
    );
  }

  Row buildBtn(BuildContext context, Post post, String userKey) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: post.numOfLikes.contains(userKey)
              ? Icon(Icons.favorite)
              : Icon(Icons.favorite_border),
          onPressed: () {
            database.toggleLike(userKey, post.postKey);
          },
        ),
        IconButton(
          icon: Icon(Icons.textsms),
          onPressed: () {
            _moveCommentPage(context, post);
          },
        ),
        IconButton(icon: Icon(Icons.comment), onPressed: () {}),
        Spacer(flex: 1),
        IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
      ],
    );
  }

  Widget buildLikesCount(List like, int numOfComments) {
    return Visibility(
      visible: numOfComments > 0,
      child: Padding(
        padding:
            const EdgeInsets.only(left: kCommon_gap, bottom: kCommon_s_gap),
        child: Text(
          '좋아요 ${like.length}개',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget postCaption(String userName, String caption, DateTime dateTime) {
    return CaptionCommentForm(
      name: userName,
      comment: caption,
      dateTime: dateTime,
      showDateTime: false,
    );
  }

  Widget lastComment(
      String userName, String comment, int numOfComment, DateTime dateTime) {
    return Visibility(
      visible: numOfComment != 0,
      child: CaptionCommentForm(
        name: userName,
        comment: comment,
        dateTime: dateTime,
        showDateTime: false,
      ),
    );
  }

  Widget showAllComments(int comments, BuildContext context, Post post) {
    return Padding(
      padding: const EdgeInsets.only(left: kCommon_gap),
      child: GestureDetector(
        onTap: () {
          _moveCommentPage(context, post);
        },
        child: Text(
          ' 댓글 $comments개 모두 보기',
          style: kCommentText,
        ),
      ),
    );
  }
}
