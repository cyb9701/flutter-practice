import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/firebase/storage.dart';
import 'package:flutterinstagramclone/utils/profile_image_path.dart';
import 'package:flutterinstagramclone/widget/comment_form.dart';
import 'package:flutterinstagramclone/widget/loading_widget.dart';

class PostForm extends StatelessWidget {
  PostForm({@required this.index});

  // user number.
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kCommon_gap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildPostHeader(),
          buildPostImg(),
          buildBtn(),
          buildLikesCount(),
          buildComment(),
        ],
      ),
    );
  }

  ListTile buildPostHeader() {
    return ListTile(
      leading: CircleAvatar(
        radius: kPostUsrImgRadius,
        backgroundImage: NetworkImage(getProfileImgPath('userName $index')),
      ),
      title: Text(
        'userName $index',
        style: kProfileText,
      ),
      trailing: IconButton(icon: Icon(Icons.more_horiz), onPressed: () {}),
    );
  }

  // cached network image package is empty space during img loading.
  Widget buildPostImg() {
    return FutureBuilder<dynamic>(
      future: storage
          .getOnlyOnePostImgUrl('1593722085254_y9HhMd2DCqN4Af8vjawYkR4IqrU2'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return CachedNetworkImage(
            width: kSize.width,
            height: kSize.width,
            fit: BoxFit.cover,
            imageUrl: snapshot.data,
            placeholder: (context, url) {
              return LoadingWidget(
                width: kSize.width,
                height: kSize.width,
              );
            },
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Row buildBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
        IconButton(icon: Icon(Icons.textsms), onPressed: () {}),
        IconButton(icon: Icon(Icons.comment), onPressed: () {}),
        Spacer(flex: 1),
        IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
      ],
    );
  }

  Padding buildLikesCount() {
    return Padding(
      padding: const EdgeInsets.only(left: kCommon_gap, bottom: kCommon_s_gap),
      child: Text(
        '좋아요 2,877개',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  CommentForm buildComment() {
    return CommentForm(
      url: getProfileImgPath('userName $index'),
      name: 'userName $index',
      comment: '가나다라마바사가나다라마바사가나다라마바사가나다라마바사가나다라마바사',
      dateTime: DateTime.now(),
    );
  }
}
