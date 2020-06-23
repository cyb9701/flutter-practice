import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/provider/my_user_data.dart';
import 'package:flutterinstagramclone/pages/add_page.dart';
import 'package:flutterinstagramclone/pages/feed_page.dart';
import 'package:flutterinstagramclone/pages/heart_page.dart';
import 'package:flutterinstagramclone/pages/profile_page.dart';
import 'package:flutterinstagramclone/pages/search_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentBottomIndex = 0;

  //index pages list.
  List<Widget> _indexPage = [
    FeedPage(),
    SearchPage(),
    Container(),
    HeartPage(),
    ProfilePage(),
  ];

  //bottom bar icons list.
  List<BottomNavigationBarItem> _bottomIconList = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('')),
    BottomNavigationBarItem(icon: Icon(Icons.search), title: Text('')),
    BottomNavigationBarItem(icon: Icon(Icons.add_box), title: Text('')),
    BottomNavigationBarItem(icon: Icon(Icons.favorite_border), title: Text('')),
    BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('')),
  ];

  //bottom icons tap change index.
  void onTapBottom(int index) {
    if (index == 2) {
      _onTapAddPageBtn(context);
    } else {
      setState(() {
        _currentBottomIndex = index;
      });
    }
  }

  void _onTapAddPageBtn(BuildContext context) async {
    final camera = await availableCameras();
    final firstCamera = camera.first;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPage(
          camera: firstCamera,
          user: Provider.of<MyUserData>(context, listen: false).getUserData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kSize == null) kSize = MediaQuery.of(context).size;
    return Scaffold(
      body: buildIndexPage(),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  IndexedStack buildIndexPage() {
    return IndexedStack(
      index: _currentBottomIndex,
      children: _indexPage,
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      backgroundColor: kAppBarColor,
      items: _bottomIconList,
      type: BottomNavigationBarType.fixed,
      onTap: onTapBottom,
      currentIndex: _currentBottomIndex,
    );
  }
}
