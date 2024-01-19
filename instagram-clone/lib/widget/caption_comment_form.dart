import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:intl/intl.dart';

class CaptionCommentForm extends StatelessWidget {
  CaptionCommentForm({
    this.showProfileImg = false,
    this.showDateTime = true,
    this.showDivider = false,
    @required this.name,
    @required this.comment,
    @required this.dateTime,
  });

  final bool showProfileImg;
  final bool showDateTime;
  final bool showDivider;
  final String name;
  final String comment;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
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
                    buildDateTime(),
                  ],
                ),
              ),
            ],
          ),
        ),
        buildDivider(),
      ],
    );
  }

  Visibility buildProfileImg() {
    return Visibility(
      visible: showProfileImg,
      child: CircleAvatar(
        radius: kPostUsrImgRadius,
        backgroundImage: AssetImage('assets/profile_Img.png'),
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
          TextSpan(
            text: comment,
            style: TextStyle(fontSize: 17.0),
          ),
        ],
      ),
    );
  }

  Widget buildDateTime() {
    return Visibility(
      visible: showDateTime,
      child: Text(
        // change date time format used intl package.
        DateFormat('MM.dd').format(dateTime),
        style: kCommentText,
      ),
    );
  }

  Visibility buildDivider() {
    return Visibility(
      visible: showDivider,
      child: Divider(
        color: Colors.grey,
        height: 30.0,
      ),
    );
  }
}
