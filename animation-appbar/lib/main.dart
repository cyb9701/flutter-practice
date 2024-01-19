import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const AnimationAppBarPage(),
    );
  }
}

class AnimationAppBarPage extends StatefulWidget {
  const AnimationAppBarPage({Key? key}) : super(key: key);

  @override
  State<AnimationAppBarPage> createState() => _AnimationAppBarPageState();
}

class _AnimationAppBarPageState extends State<AnimationAppBarPage> {
  /// 스크롤 컨트롤러.
  late ScrollController _scrollController;

  /// 앱바의 노출 여부 확인 변수.
  bool _exposureAppBar = true;

  /// 스크롤 방향에 따른 앱바 노출 여부 상태 변경.
  void _changeExposureAppBarState() {
    try {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        if (_exposureAppBar) {
          setState(() {
            _exposureAppBar = false;
          });
        }
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        if (!_exposureAppBar) {
          setState(() {
            _exposureAppBar = true;
          });
        }
      }
    } catch (_) {}
  }

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_changeExposureAppBarState);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _animationAppBar(),
      body: _body(),
    );
  }

  /// 애니메이션 앱바.
  PreferredSize _animationAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: SafeArea(
        child: AnimatedCrossFade(
          firstChild: AppBar(
            leading: const Icon(Icons.arrow_back_ios_new_rounded),
            backgroundColor: Colors.blueAccent,
            title: const Text('앱바'),
          ),
          secondChild: const SizedBox.shrink(),
          crossFadeState: _exposureAppBar ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 200),
        ),
      ),
    );
  }

  /// 리스트뷰.
  ListView _body() {
    return ListView.separated(
      controller: _scrollController,
      itemCount: 100,
      itemBuilder: (context, index) {
        return Container(
          height: 50,
          color: Colors.grey[700],
          child: Center(
            child: Text(
              index.toString(),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(height: 10),
    );
  }
}
