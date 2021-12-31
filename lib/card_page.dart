import 'package:card_gradient/my_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'color.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBlack,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    return Align(
      alignment: Alignment.centerLeft,
      child: CupertinoButton(
        pressedOpacity: 1,
        onPressed: () {},
        child: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: kWhite,
        ),
      ),
    );
  }

  // 카드.
  CustomPaint _myCard() {
    return CustomPaint(
      size: const Size(300, 500),
      painter: CardPainter(),
    );
  }

  // 복사 버튼.
  CupertinoButton _copyButton() {
    return CupertinoButton(
      pressedOpacity: 1,
      onPressed: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: kGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Center(
          child: Text(
            '카드번호 복사',
            style: TextStyle(
              color: kWhite,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
