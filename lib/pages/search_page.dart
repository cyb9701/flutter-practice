import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/data/user.dart';
import 'package:flutterinstagramclone/firebase/database.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: StreamProvider(
        create: (context) => database.fetchAllUsersExceptMe(),
        child: SafeArea(
          child: Consumer<List<User>>(
            builder: (context, userList, child) {
              return ListView.separated(
                itemCount: userList == null ? 0 : userList.length,
                itemBuilder: (context, index) {
                  return _items(userList[index]);
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 0.5,
                    height: 10.0,
                    color: Colors.grey[800],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _items(User otherUsers) {
    return Consumer<MyUserData>(
      builder: (context, myUserData, child) {
        bool isFollowing = myUserData.amIFollowingOtherUser(otherUsers.userKey);
        return Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kCommon_s_gap, vertical: kCommon_xxxs_gap),
          child: ListTile(
            leading: CircleAvatar(
              radius: kSearchUsrImgRadius,
              backgroundImage: AssetImage('assets/profile_Img.png'),
            ),
            title: Text(otherUsers.userName),
            subtitle: Text(otherUsers.email),
            trailing: FlatButton(
              onPressed: () {
                isFollowing
                    ? database.unFollowUser(
                        myUserData.getUserData.userKey, otherUsers.userKey)
                    : database.followUser(
                        myUserData.getUserData.userKey, otherUsers.userKey);
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
      },
    );
  }
}
