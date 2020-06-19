import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:intl/intl.dart';

class CommentForm extends StatelessWidget {
  CommentForm({
    this.showProfileImg = false,
    @required this.url,
    @required this.name,
    @required this.comment,
    @required this.dateTime,
  });

  final bool showProfileImg;
  final String url;
  final String name;
  final String comment;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kCommon_l_gap),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildProfileImg(),

          // if profile img hide, sized box also hide.
          Visibility(
            visible: showProfileImg,
            child: SizedBox(width: kCommon_xs_gap),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildNameComment(),
                Row(
                  children: <Widget>[
                    buildDateTime(),
                    SizedBox(width: kCommon_l_gap),
                    buildCommentBtn(),
                  ],
                ),
                buildDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Visibility buildProfileImg() {
    return Visibility(
      visible: showProfileImg,
      child: CircleAvatar(
        radius: kPostUsrImgRadius,
        backgroundImage: NetworkImage(url),
      ),
    );
  }

  RichText buildNameComment() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: name,
            style: kProfileText,
          ),
          TextSpan(text: '  '),
          TextSpan(text: comment),
        ],
      ),
    );
  }

  Text buildDateTime() {
    return Text(
      // change date time format used intl package.
      DateFormat('MM.dd').format(dateTime),
      style: kCommentText,
    );
  }

  GestureDetector buildCommentBtn() {
    return GestureDetector(
      onTap: () {},
      child: Text(
        '답글 달기',
        style: kCommentText,
      ),
    );
  }

  Visibility buildDivider() {
    return Visibility(
      visible: showProfileImg,
      child: Divider(),
    );
  }
}
