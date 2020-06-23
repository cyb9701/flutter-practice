import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/widget/profile_menu_list.dart';
import 'package:provider/provider.dart';

class ProfileMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 50.0),
      decoration: BoxDecoration(
        color: kMenuColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kProfileMenuRadius),
          topRight: Radius.circular(kProfileMenuRadius),
        ),
      ),
      child: Column(
        children: <Widget>[
          Divider(
            thickness: 3.0,
            color: Colors.grey,
            endIndent: kSize.width * 0.40,
            indent: kSize.width * 0.40,
          ),
          ProfileMenuList(
              icon: Icons.cloud_off,
              title: '로그아웃',
              onTap: () {
                Navigator.pop(context);
                FirebaseAuth.instance.signOut();
                Provider.of<MyUserData>(context, listen: false).cleanUserData();
              }),
          ProfileMenuList(icon: Icons.settings, title: '설정', onTap: () {}),
          ProfileMenuList(icon: Icons.save_alt, title: '보관', onTap: () {}),
          ProfileMenuList(icon: Icons.timeline, title: '인사이트', onTap: () {}),
          ProfileMenuList(icon: Icons.timelapse, title: '내 활동', onTap: () {}),
          ProfileMenuList(icon: Icons.art_track, title: '네임 태그', onTap: () {}),
          ProfileMenuList(
              icon: Icons.bookmark_border, title: '저장됨', onTap: () {}),
          ProfileMenuList(
              icon: Icons.format_list_bulleted, title: '친한 친구', onTap: () {}),
          ProfileMenuList(
              icon: Icons.group_add, title: '사람 찾아보기', onTap: () {}),
        ],
      ),
    );
  }
}
