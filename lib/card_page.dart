import 'package:card_gradient/my_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'color.dart';
import 'dart:ui' as ui;

class CardPage extends StatefulWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  // size.
  late Size _size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: SafeArea(
        child: Column(
          children: [
            _appBar(),
            _myCard(),
            _copyButton(),
          ],
        ),
      ),
    );
  }

  // 앱바.
  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Align(
        alignment: Alignment.centerLeft,
        child: CupertinoButton(
          pressedOpacity: 1,
          onPressed: () {},
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // 카드.
  Widget _myCard() {
    final double _width = _size.width - 64;
    final double _height = (_size.width - 64) * 5 / 3;

    return Stack(
      children: [
        // 카드 형태.
        CustomPaint(
          size: Size(_width, _height),
          painter: CardPainter(),
        ),

        // 카드 정보.
        Positioned(
          left: 30,
          bottom: _height / 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 카드 번호.
              _cardInformation(title: '카드번호', information: '0000 0000 0000 0000'),

              // 유효기간 + CVV.
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Row(
                  children: [
                    // 유효기간.
                    _cardInformation(title: '유효기간', information: '03 / 20'),

                    // padding.
                    const SizedBox(width: 32),

                    // cvv.
                    _cardInformation(title: 'CVV', information: '000'),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 토스 마크.
        Positioned(
          right: 20,
          bottom: 20,
          child: Text(
            'toss bank',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              foreground: Paint()
                ..shader = ui.Gradient.linear(
                  const Offset(0, 20),
                  const Offset(150, 20),
                  [
                    Colors.white,
                    Colors.black,
                  ],
                ),
            ),
          ),
        ),
      ],
    );
  }

  // 카드 정보.
  Widget _cardInformation({required String title, required String information}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 카드 정보 타이틀.
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),

        // padding.
        const SizedBox(height: 5),

        // 카드 정보.
        Text(
          information,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // 복사 버튼.
  CupertinoButton _copyButton() {
    return CupertinoButton(
      pressedOpacity: 1,
      onPressed: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: kGreyButton,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            '카드번호 복사',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
