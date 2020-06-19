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
              color: Colors.grey[700],
            );
          },
        ),
      ),
    );
  }

  ListTile _items(String users) {
    return ListTile(
      leading: CircleAvatar(
        radius: kSearchUsrImgRadius,
        backgroundImage: NetworkImage(getProfileImgPath(users)),
      ),
      title: Text(users),
      subtitle: Text('This is $users bio.'),
      trailing: Text(
        'following',
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }
}
