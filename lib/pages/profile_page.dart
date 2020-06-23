import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/pages/profile_menu_page.dart';
import 'package:flutterinstagramclone/utils/profile_image_path.dart';
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
    return Scaffold(
      backgroundColor: kAppBarColor,
      appBar: buildAppBar(context),
      body: ListView(
        children: <Widget>[
          buildDivider(),
          buildProfileHeader(),
          buildUsrName(),
          buildUsrInformation(),
          buildEditBtn(),
          buildDivider(),
          buildGridBtn(),
          buildAnimationLine(),
          buildGridStack(),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kAppBarColor,
      title: Text('userName 0'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            //click the button below to scroll through from the screen.
            showModalBottomSheet(
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

  Padding buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kCommon_gap, kCommon_s_gap, kCommon_xxxl_gap, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            radius: kUsrImgRadius,
            backgroundImage: NetworkImage(
              getProfileImgPath('userName 0'),
            ),
          ),
          buildStatusValueWidget('10', '게시물'),
          buildStatusValueWidget('2346', '팔로워'),
          buildStatusValueWidget('569', '팔로잉'),
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

  Padding buildUsrName() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(kCommon_gap, kCommon_gap, 0, 0),
      child: Consumer<MyUserData>(
        builder: (context, value, child) =>
            Text(value.getUserData.userName, style: kProfileText),
      ),
    );
  }

  Padding buildUsrInformation() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kCommon_gap, kCommon_xxxs_gap, 0, kCommon_s_gap),
      child: Text(
        '안녕하세요. 최유빈입니다.',
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
          padding: EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBtnRadius),
            border: Border.all(color: Colors.white, width: 0.2),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: kProfileText,
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
            icon: Icon(Icons.grid_on),
            onPressed: () {
              setTab(true);
            },
          ),
        ),
        Container(
          width: kSize.width * 0.5,
          child: IconButton(
            icon: Icon(Icons.account_box),
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
          child: _imgGrid,
        ),
        AnimatedContainer(
          transform: Matrix4.translationValues(_usrGrid, 0, 0),
          duration: _duration,
          curve: Curves.easeInOut,
          child: _imgGrid,
        ),
      ],
    );
  }

  GridView get _imgGrid => GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1,
        children: List.generate(9, (index) => _gridImgItem(index)),
      );

  CachedNetworkImage _gridImgItem(int index) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: "https://picsum.photos/id/$index/1000/1000",
      placeholder: (context, url) {
        return LoadingWidget(
          width: kSize.width / 3,
          height: kSize.width / 3,
        );
      },
    );
  }

  Divider buildDivider() => Divider(color: Colors.grey.withOpacity(0.3));
}
