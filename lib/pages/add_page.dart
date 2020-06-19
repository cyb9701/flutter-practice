import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int _currentIndex = 0;
  PageController _pageController;

  List<BottomNavigationBarItem> _bottomTextList = [
    BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('라이브러리')),
    BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('사진')),
    BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('동영상')),
  ];

  //if tap bottom navigation bar, change the page view.
  void _bottomOnTap(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(context),
      body: buildPageView(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kAppBarColor,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text('게시물 추가'),
    );
  }

  PageView buildPageView() {
    return PageView(
      controller: _pageController,

      //if scrolled page, chang the bottom navigation bar.
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      children: <Widget>[
        buildLibraryPage(),
        buildPhotoPage(),
        buildVideoPage(),
      ],
    );
  }

  Widget buildLibraryPage() {
    return Container(
      color: Colors.redAccent,
    );
  }

  Widget buildPhotoPage() {
    return Container(
      color: Colors.blueAccent,
    );
  }

  Widget buildVideoPage() {
    return Container(
      color: Colors.greenAccent,
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      iconSize: 0,
      selectedItemColor: Colors.white,
      selectedLabelStyle:
          TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
      unselectedItemColor: Colors.grey,
      unselectedFontSize: 13.0,
      items: _bottomTextList,
      currentIndex: _currentIndex,
      onTap: (index) => _bottomOnTap(index),
    );
  }
}
