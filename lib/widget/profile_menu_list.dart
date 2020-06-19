import 'package:flutter/material.dart';

class ProfileMenuList extends StatelessWidget {
  ProfileMenuList(
      {@required this.icon, @required this.title, @required this.onTap});

  final IconData icon;
  final String title;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            icon,
          ),
          title: Text(
            title,
          ),
          onTap: onTap,
        ),
        Divider(
          color: Colors.grey.withOpacity(0.5),
          height: 3.0,
        )
      ],
    );
  }
}
