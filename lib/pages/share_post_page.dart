import 'dart:io';

import 'package:flutter/material.dart';

class SharePostPage extends StatefulWidget {
  const SharePostPage({Key key, @required this.imgFile}) : super(key: key);

  final File imgFile;

  @override
  _SharePostPageState createState() => _SharePostPageState();
}

class _SharePostPageState extends State<SharePostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.file(widget.imgFile),
      ),
    );
  }
}
