import 'package:flutter/material.dart';

class ShareAddInform extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const ShareAddInform({Key key, @required this.title, @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing:
          IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: onTap),
    );
  }
}
