import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class GiftCardPage extends StatefulWidget {
  final Color colors;
  final int tag;

  const GiftCardPage({
    Key? key,
    required this.colors,
    required this.tag,
  }) : super(key: key);

  @override
  _GiftCardPageState createState() => _GiftCardPageState();
}

class _GiftCardPageState extends State<GiftCardPage> with TickerProviderStateMixin {
  // 카드 사이즈.
  static const double _cardWidth = 320;
  static const double _cardHeight = 200;

  // 카드 수량.
  int _cardQuantity = 1;
  int _animationCardQuantity = 1;

  // 카드 위치 애니메이션.
  late Animation<double> _animation;
  late AnimationController _controller;

  // 증감 버튼 클릭.
  bool _clickedDecreaseButton = false;
  bool _clickedIncreaseButton = false;

  // 증감 버튼 애니메이션 효과 시간.
  final Duration _animationDuration = const Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();
    // 카드 초기 애니메이션.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInSine,
    )..addListener(() {
        // 상태 변경.
        setState(() {});
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // 앱바.
              _appbar(),

              // 카드.
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //TODO: 카드 증가시, 바운스 애니메이션. 카드 추가 될때마다 아래에서 새로 나오는 애니메이션
                    Hero(
                      tag: widget.tag,
                      child: Transform.rotate(
                        angle: _animation.value * (-math.pi / 30),
                        child: Stack(
                          children: List.generate(
                            _animationCardQuantity,
                            (index) {
                              final _index = _animationCardQuantity - index - 1;
                              return Transform(
                                transform: Matrix4.identity()
                                  // 원근법.
                                  ..setEntry(3, 2, -0.000001 * _index)

                                  // 이동.
                                  ..setEntry(0, 3, -1.5 * _index)
                                  ..setEntry(1, 3, -2.0 * _index)
                                  // 회전.
                                  ..rotateX(-0.075 * _index)
                                  ..rotateY(0.07 * _index),
                                child: _giftCard(index: _index),
                              );
                            },
                          ).reversed.toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 카드 수량 증감 버튼.
              _countChangingButton(),

              // 구매 버튼.
              _paymentButton(),
            ],
          ),
        ),
      ),
    );
  }

  // 앱바.
  Widget _appbar() {
    return Container(
      height: 64,
      width: double.infinity,
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 나가기 버튼.
          CupertinoButton(
            pressedOpacity: 1,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.white,
            ),
          ),

          // 안내 버튼.
          const CupertinoButton(
            onPressed: null,
            child: Text(
              '안내',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 기프트 카드.
  Container _giftCard({required int index}) {
    final _shadowList = [
      Colors.black12,
      Colors.black26,
      Colors.black38,
      Colors.black45,
      Colors.black54,
    ];
    return Container(
      width: _cardWidth,
      height: _cardHeight,
      decoration: BoxDecoration(
        color: widget.colors,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: _shadowList.elementAt(index),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(5, 5),
          ),
        ],
      ),
    );
  }

  // 카드 수량 증감 버튼.
  Container _countChangingButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        children: [
          // 타이틀.
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              '30,000원 권을 몇 개 구매하시나요?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          // 증감 버튼.
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 감소 버튼.
              SizedBox(
                width: 84,
                height: 84,
                child: CupertinoButton(
                  onPressed: (_cardQuantity != 1)
                      ? () {
                          // 수량 감소.
                          if (_cardQuantity < 6) {
                            _animationCardQuantity--;
                          }
                          _cardQuantity--;
                          _clickedDecreaseButton = !_clickedDecreaseButton;

                          // 상태 변경.
                          setState(() {});

                          Future.delayed(_animationDuration, () {
                            setState(() {
                              _clickedDecreaseButton = !_clickedDecreaseButton;
                            });
                          });
                        }
                      : null,
                  child: AnimatedContainer(
                    width: !_clickedDecreaseButton ? 42 : 52,
                    height: !_clickedDecreaseButton ? 42 : 52,
                    duration: _animationDuration,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.remove_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // 수량.
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  '$_cardQuantity개',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              // 증가 버튼.
              SizedBox(
                width: 84,
                height: 84,
                child: CupertinoButton(
                  onPressed: () {
                    // 수량 감소.
                    _cardQuantity++;
                    _clickedIncreaseButton = !_clickedIncreaseButton;
                    if (_animationCardQuantity < 5) {
                      _animationCardQuantity++;
                    }

                    // 상태변경.
                    setState(() {});

                    Future.delayed(_animationDuration, () {
                      setState(() {
                        _clickedIncreaseButton = !_clickedIncreaseButton;
                      });
                    });
                  },
                  child: AnimatedContainer(
                    width: !_clickedIncreaseButton ? 42 : 52,
                    height: !_clickedIncreaseButton ? 42 : 52,
                    duration: _animationDuration,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 구매 버튼.
  Container _paymentButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          '30,000원 권 $_cardQuantity개를 구매하기',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
