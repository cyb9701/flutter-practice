import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/post.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/firebase/database.dart';
import 'package:flutterinstagramclone/pages/profile_menu_page.dart';
import 'package:flutterinstagramclone/widget/loading_widget.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AlignmentGeometry tabAlign =
      Alignment.centerLeft; //started usrGrid, tagGrid is hide.
  Duration _duration = Duration(milliseconds: 300);
  double _usrGrid = 0;
  double _tagGrid = kSize.width;

  void setTab(bool tabLeft) {
    setState(
      () {
        if (tabLeft) {
          this.tabAlign = Alignment.centerLeft;
          _usrGrid = 0;
          _tagGrid = kSize.width;
        } else {
          this.tabAlign = Alignment.centerRight;
          _usrGrid = -kSize.width;
          _tagGrid = 0;
        }
      },
    );
  } //usrGrid and tagGrid controller.

  @override
  Widget build(BuildContext context) {
    return Consumer<MyUserData>(
      builder: (context, userData, child) {
        return Scaffold(
          backgroundColor: kAppBarColor,
          appBar: buildAppBar(context, userData.getUserData.userName),
          body: ListView(
            children: <Widget>[
              buildProfileHeader(
                  userData.getUserData.myPosts,
                  userData.getUserData.followers,
                  userData.getUserData.followings),
              buildUsrName(userData.getUserData.userName),
              buildUsrInformation(userData.getUserData.email),
              buildEditBtn(),
              buildDivider(),
              buildGridBtn(),
              buildAnimationLine(),
              buildGridStack(),
            ],
          ),
        );
      },
    );
  }

  AppBar buildAppBar(BuildContext context, String userName) {
    return AppBar(
      backgroundColor: kAppBarColor,
      title: Text(userName),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            //click the button below to scroll through from the screen.
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kProfileMenuRadius),
              ),
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ProfileMenuPage(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Padding buildProfileHeader(List myPosts, int follower, List following) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kCommon_gap, kCommon_s_gap, kCommon_xxxl_gap, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            radius: kUsrImgRadius,
            backgroundImage: AssetImage('assets/profile_Img.png'),
          ),
          buildStatusValueWidget(myPosts.length.toString(), '게시물'),
          buildStatusValueWidget(follower.toString(), '팔로워'),
          buildStatusValueWidget(following.length.toString(), '팔로잉'),
        ],
      ),
    );
  }

  Column buildStatusValueWidget(String value, String title) {
    return Column(
      children: <Widget>[
        Text(value),
        Text(title),
      ],
    );
  }

  Padding buildUsrName(String userName) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kCommon_gap, kCommon_gap, 0, 0),
      child: Text(userName, style: kProfileText),
    );
  }

  Padding buildUsrInformation(String email) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kCommon_gap, kCommon_xxxs_gap, 0, kCommon_s_gap),
      child: Text(
        email,
        style: kProfileInformationText,
      ),
    );
  }

  Padding buildEditBtn() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(kCommon_gap, 0, kCommon_gap, kCommon_s_gap),
      child: Row(
        children: <Widget>[
          buildProfileEditBtn('프로필 수정', () {}),
          SizedBox(width: 10.0),
          buildProfileEditBtn('홍보', () {}),
          SizedBox(width: 10.0),
          buildProfileEditBtn('인사이트', () {}),
        ],
      ),
    );
  }

  Widget buildProfileEditBtn(String title, Function onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBtnRadius),
            border: Border.all(color: Colors.white, width: 0.2),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: kProfileText.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }

  Row buildGridBtn() {
    return Row(
      children: <Widget>[
        Container(
          width: kSize.width * 0.5,
          child: IconButton(
            icon: Icon(
              Icons.grid_on,
              color: _usrGrid == 0 ? Colors.white : Colors.grey,
            ),
            onPressed: () {
              setTab(true);
            },
          ),
        ),
        Container(
          width: kSize.width * 0.5,
          child: IconButton(
            icon: Icon(
              Icons.account_box,
              color: _tagGrid == 0 ? Colors.white : Colors.grey,
            ),
            onPressed: () {
              setTab(false);
            },
          ),
        ),
      ],
    );
  }

  AnimatedContainer buildAnimationLine() {
    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 2.0),
      alignment: tabAlign,
      curve: Curves.easeInOut,
      height: 1.0,
      width: kSize.width,
      color: Colors.transparent,
      duration: _duration,
      child: Container(
        color: Colors.white,
        width: kSize.width * 0.5,
        height: 1.0,
      ),
    );
  }

  Stack buildGridStack() {
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          transform: Matrix4.translationValues(_tagGrid, 0, 0),
          duration: _duration,
          curve: Curves.easeInOut,
          child: null,
        ),
        AnimatedContainer(
          transform: Matrix4.translationValues(_usrGrid, 0, 0),
          duration: _duration,
          curve: Curves.easeInOut,
          child: _myPostImg,
        ),
      ],
    );
  }

  Widget get _myPostImg {
    return StreamProvider<List<Post>>.value(
      value: database.fetchAllMyPosts(
          Provider.of<MyUserData>(context).getUserData.userKey),
      child: Consumer<List<Post>>(
        builder: (context, myPostList, child) {
          return GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 1,
            children: List.generate(
              myPostList == null ? 0 : myPostList.length,
              (index) {
                myPostList.sort((a, b) => b.postTime.compareTo(a.postTime));
                return myPostItem(myPostList[index]);
              },
            ),
          );
        },
      ),
    );
  }

//  Widget get _likePosts {
//    return StreamProvider<List<Post>>.value(
//      value: database.fetchMyLikePosts(
//          Provider.of<MyUserData>(context).getUserData.userKey),
//      child: Consumer<List<Post>>(
//        builder: (context, likePostList, child) {
//          print('@@@@@@@@@ ${likePostList.length}');
//          return GridView.count(
//            physics: NeverScrollableScrollPhysics(),
//            shrinkWrap: true,
//            crossAxisCount: 3,
//            mainAxisSpacing: 2,
//            crossAxisSpacing: 2,
//            childAspectRatio: 1,
//            children: List.generate(
//              likePostList == null ? 0 : likePostList.length,
//              (index) {
//                likePostList.sort((a, b) => b.postTime.compareTo(a.postTime));
//                return myPostItem(likePostList[index]);
//              },
//            ),
//          );
//        },
//      ),
//    );
//  }

  Widget myPostItem(Post post) {
    return CachedNetworkImage(
      imageUrl: post.postUrl,
      width: kSize.width / 3,
      height: kSize.width / 3,
      fit: BoxFit.cover,
      placeholder: (context, url) {
        return LoadingWidget(
          width: kSize.width / 3,
          height: kSize.width / 3,
        );
      },
    );
  }

//  CachedNetworkImage _gridImgItem(int index) {
//    return CachedNetworkImage(
//      fit: BoxFit.cover,
//      imageUrl: "https://picsum.photos/id/$index/1000/1000",
//      placeholder: (context, url) {
//        return LoadingWidget(
//          width: kSize.width / 3,
//          height: kSize.width / 3,
//        );
//      },
//    );
//  }

  Divider buildDivider() => Divider(color: Colors.grey.withOpacity(0.3));
}
