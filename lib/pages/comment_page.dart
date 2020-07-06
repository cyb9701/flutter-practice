import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/comment.dart';
import 'package:flutterinstagramclone/data/post.dart';
import 'package:flutterinstagramclone/data/user.dart';
import 'package:flutterinstagramclone/firebase/database.dart';
import 'package:flutterinstagramclone/widget/caption_comment_form.dart';
import 'package:provider/provider.dart';

class CommentPage extends StatefulWidget {
  final Post post;
  final User user;

  const CommentPage({Key key, @required this.post, @required this.user})
      : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  TextEditingController _textEditingController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: commentAppbar(),
      body: commentPageBody(),
    );
  }

  AppBar commentAppbar() {
    return AppBar(
      backgroundColor: kBackgroundColor,
      title: Text(
        '댓글',
        style: TextStyle(),
      ),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.message), onPressed: () {}),
      ],
    );
  }

  Widget commentPageBody() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          allOfComments(),
          commentTextField(),
        ],
      ),
    );
  }

  //Used .value. Because Always Update Data.
  Widget allOfComments() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 6.0),
        child: StreamProvider<List<Comment>>.value(
          value: database.fetchAllComments(widget.post.postKey),
          child: Consumer<List<Comment>>(
            builder: (context, commentList, child) {
              return ListView(
                children: <Widget>[
                  CaptionCommentForm(
                    name: widget.post.username,
                    comment: widget.post.caption,
                    dateTime: widget.post.postTime,
                    showProfileImg: true,
                    showDivider: true,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Comment comment = commentList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30.0),
                        child: CaptionCommentForm(
                          name: comment.username,
                          comment: comment.comment,
                          dateTime: comment.commentTime,
                          showProfileImg: true,
                        ),
                      );
                    },
                    itemCount: commentList == null ? 0 : commentList.length,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget commentTextField() {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
        decoration: BoxDecoration(
          color: kAppBarColor,
          border: Border(
            top: BorderSide(
              color: Colors.grey[700],
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _userProfileImg(),
            SizedBox(width: 10.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(40.0),
                  ),
                  border: Border.all(
                    color: Colors.grey[700],
                    width: 2.0,
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: _commentTextFormField(),
                    ),
                    _createCommentBtn(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  CircleAvatar _userProfileImg() {
    return CircleAvatar(
      radius: kSearchUsrImgRadius,
      backgroundImage: AssetImage('assets/profile_Img.png'),
    );
  }

  Container _commentTextFormField() {
    return Container(
      child: TextFormField(
        controller: _textEditingController,
        validator: (String comment) {
          if (comment.isEmpty) {
            return '댓글을 입력해주세요...';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: '댓글 달기...',
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  GestureDetector _createCommentBtn() {
    return GestureDetector(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          await database.createNewComment(
              Comment.getMapForNewComment(widget.user.userKey,
                  widget.user.userName, _textEditingController.text),
              widget.post.postKey);

          print('@@@@@@ Complete Create Comment @@@@@@');
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          _textEditingController.clear();
        }
      },
      child: Text(
        '게시',
        style: kProfileText.copyWith(
          color: Colors.blue,
        ),
      ),
    );
  }
}

//CaptionCommentForm(
//name: widget.post.username,
//comment: widget.post.caption,
//dateTime: widget.post.postTime,
//showProfileImg: true,
//showDivider: true,
//),
