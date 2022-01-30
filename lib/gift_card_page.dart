import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class _GiftCardPageState extends State<GiftCardPage> {
  // 카드 수량.
  int _countCard = 1;

  // 증감 버튼 클릭.
  bool _clickedDecreaseButton = false;
  bool _clickedIncreaseButton = false;

  // 애니메이션 효과 시간.
  final Duration _animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Hero(
                    tag: widget.tag,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: widget.colors,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      height: 200,
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
                  onPressed: (_countCard != 1)
                      ? () {
                          // 수량 감소.
                          setState(() {
                            _countCard--;
                            _clickedDecreaseButton = !_clickedDecreaseButton;
                          });

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
                  '$_countCard개',
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
                    setState(() {
                      _countCard++;
                      _clickedIncreaseButton = !_clickedIncreaseButton;
                    });

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
          '30,000원 권 $_countCard개를 구매하기',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
