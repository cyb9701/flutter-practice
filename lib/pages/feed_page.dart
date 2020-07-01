import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/widget/post_form.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      body: buildPost(),
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

  ListView buildPost() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => PostForm(
        index: index,
      ),
    );
  }
}
