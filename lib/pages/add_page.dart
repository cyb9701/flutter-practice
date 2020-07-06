import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterinstagramclone/constants/color.dart';
import 'package:flutterinstagramclone/constants/size.dart';
import 'package:flutterinstagramclone/data/user.dart';
import 'package:flutterinstagramclone/pages/share_post_page.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AddPage extends StatefulWidget {
  AddPage({
    @required this.camera,
    @required this.user,
  });

  CameraDescription camera;
  User user;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  int _currentIndex = 0;
  PageController _pageController;
  CameraController _cameraController;
  Future<void> _initializeControllerFuture;

  List<BottomNavigationBarItem> _bottomTextList = [
    BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('라이브러리')),
    BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('사진')),
    BottomNavigationBarItem(icon: Icon(Icons.add), title: Text('동영상')),
  ];

  //if tap bottom navigation bar, change the page view.
  void _tapBottom(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void attemptTakePhoto(BuildContext context) async {
    final String postKey =
        '${DateTime.now().millisecondsSinceEpoch}_${widget.user.userKey}';

    try {
      await _initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}_${widget.user.userName}.png',
      );
      await _cameraController.takePicture(path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SharePostPage(
            imgFile: File(path),
            postKey: postKey,
            user: widget.user,
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    _cameraController = CameraController(widget.camera, ResolutionPreset.high);
    _initializeControllerFuture = _cameraController.initialize();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _cameraController.dispose();
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
      color: kBackgroundColor,
    );
  }

  Widget buildPhotoPage() {
    return FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: <Widget>[
                Container(
                  width: kSize.width,
                  height: kSize.width,
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.topCenter,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          width: kSize.width,
                          height:
                              kSize.width / _cameraController.value.aspectRatio,
                          child: CameraPreview(_cameraController),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      attemptTakePhoto(context);
                    },
                    child: Center(
                      child: Container(
                        width: kSize.width / 4.5,
                        height: kSize.width / 4.5,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: CircleBorder(
                            side: BorderSide(color: Colors.grey, width: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        });
  }

  Widget buildVideoPage() {
    return Container(
      color: kBackgroundColor,
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
      onTap: (index) => _tapBottom(index),
    );
  }
}
