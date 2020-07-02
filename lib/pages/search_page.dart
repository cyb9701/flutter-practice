import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/utils/profile_image_path.dart';

class SearchPage extends StatelessWidget {
  final List<String> _users = List.generate(20, (i) => 'user $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView.separated(
          itemCount: 8,
          itemBuilder: (context, index) {
            return _items(_users[index]);
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 0.5,
              height: 10.0,
              color: Colors.grey[800],
            );
          },
        ),
      ),
    );
  }

  Widget _items(String users) {
    bool isFollowing = false;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kCommon_s_gap, vertical: kCommon_xxxs_gap),
      child: ListTile(
        leading: CircleAvatar(
          radius: kSearchUsrImgRadius,
          backgroundImage: NetworkImage(getProfileImgPath(users)),
        ),
        title: Text(users),
        subtitle: Text('This is $users bio.'),
        trailing: FlatButton(
          onPressed: () {
            isFollowing = true;
          },
          child: Text(
            isFollowing ? '팔로우 취소' : '팔로우',
            textScaleFactor: 1.1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isFollowing ? Colors.redAccent : Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
