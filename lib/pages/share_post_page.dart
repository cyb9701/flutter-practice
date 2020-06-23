import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/isolates/resize_img.dart';
import 'package:flutterinstagramclone/widget/share_add_inform.dart';
import 'package:flutterinstagramclone/widget/share_switch.dart';

class SharePostPage extends StatefulWidget {
  final File imgFile;
  final String postKey;

  const SharePostPage({Key key, @required this.imgFile, this.postKey})
      : super(key: key);

  @override
  _SharePostPageState createState() => _SharePostPageState();
}

class _SharePostPageState extends State<SharePostPage> {
  TextEditingController _captionController;
  bool _isImgProgressing = false;

  void _uploadImgNCreatePost() async {
    setState(() {
      _isImgProgressing = true;
    });

    try {
      final File resized = await compute(getResizedImg, widget.imgFile);

      setState(() {
        _isImgProgressing = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _captionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IgnorePointer(
          ignoring: _isImgProgressing,
          child: Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: sharePageAppBar(),
            body: Column(
              children: <Widget>[
                thumbnailCaption(),
                divider,
                ShareAddInform(title: '사람 태그하기', onTap: () {}),
                divider,
                ShareAddInform(title: '위치 추가', onTap: () {}),
                _addLocationTags(),
                divider,
                ShareSwitch(title: 'Facebook'),
                ShareSwitch(title: 'Twitter'),
                ShareSwitch(title: 'Tumblr'),
                divider,
              ],
            ),
          ),
        ),
        Visibility(
          visible: _isImgProgressing,
          child: Container(
            color: kBackgroundColor,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ],
    );
  }

  AppBar sharePageAppBar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      title: Text('게시물'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _uploadImgNCreatePost();
          },
          child: Text(
            '공유',
            textScaleFactor: 1.5,
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget thumbnailCaption() {
    return Container(
      margin: EdgeInsets.all(kCommon_l_gap),
      width: kSize.width,
      height: kSize.width / 6 + 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.file(
            widget.imgFile,
            width: kSize.width / 5.5,
            height: kSize.width / 5.5,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 15.0),
          Expanded(
            child: Container(
              child: TextField(
                expands: true,
                maxLines: null,
                controller: _captionController,
                autofocus: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: '문구입력...',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addLocationTags() {
    List<String> _items = [
      "approval",
      "pigeon",
      "brown",
      "expenditure",
      "compromise",
      "citizen",
      "inspire",
      "relieve",
      "grave",
      "incredible",
      "invasion",
      "voucher",
      "girl",
      "relax",
      "problem",
      "queue",
      "aviation",
      "profile",
      "palace",
      "drive",
      "money",
      "revolutionary",
      "string",
      "detective",
      "follow",
      "text",
      "bet",
      "decade",
      "means",
      "gossip"
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Tags(
        horizontalScroll: true,
        itemCount: _items.length,
        itemBuilder: (int index) {
          final item = _items[index];
          return ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            activeColor: Colors.grey[800],
            textActiveColor: Colors.white70,
            textStyle: TextStyle(
              fontSize: 15,
            ),
            borderRadius: BorderRadius.circular(5),
          );
        },
      ),
    );
  }

  Divider get divider => Divider(color: Colors.grey);
}
