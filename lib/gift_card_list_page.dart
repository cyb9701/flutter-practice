import 'dart:ui';

import 'package:flutter/material.dart';

class GiftCardListPage extends StatefulWidget {
  const GiftCardListPage({Key? key}) : super(key: key);

  @override
  _GiftCardListPageState createState() => _GiftCardListPageState();
}

class _GiftCardListPageState extends State<GiftCardListPage> {
  // app bar style.
  late double _appBarHeight;
  Color _appBarColors = Colors.transparent;

  // size.
  late EdgeInsets _padding;

  // scroll controller.
  late ScrollController _scrollController;

  // change app bar color
  void _changeAppBarColor() {
    if (_scrollController.hasClients) {
      if (_scrollController.offset > 0) {
        _appBarColors = Colors.grey.shade800.withOpacity(0.5);
      } else {
        _appBarColors = Colors.transparent;
      }

      // 상태 변경.
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_changeAppBarColor);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _padding = MediaQuery.of(context).padding;
    _appBarHeight = 64 + _padding.top;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff18181f),
      body: Stack(
        children: [
          // 리스트.
          ListView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20) +
                EdgeInsets.only(top: _appBarHeight, bottom: _padding.bottom),
            children: [
              // 타이틀.
              const Text(
                '상품권을 선택해주세요',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),

              ...List.generate(
                Colors.accents.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 100,
                  color: Colors.accents.elementAt(index),
                ),
              ),
            ],
          ),

          // 앱바.
          _appbar(),
        ],
      ),
    );
  }

  // 앱바.
  ClipRect _appbar() {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: _appBarHeight,
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          color: _appBarColors,
          padding: const EdgeInsets.all(16),
          child: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
    );
  }
}
