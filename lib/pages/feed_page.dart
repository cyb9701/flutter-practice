import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/widget/post_form.dart';
import 'package:google_fonts/google_fonts.dart';

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
      leading: IconButton(
        icon: Icon(
          Icons.camera_alt,
        ),
        onPressed: () {},
      ),
      title: Text(
        'Instagram',
        style: GoogleFonts.bilboSwashCaps(fontSize: 35.0),
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
