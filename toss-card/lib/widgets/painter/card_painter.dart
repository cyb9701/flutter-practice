import 'package:card_gradient/constants/constants.dart';
import 'package:flutter/rendering.dart';

class CardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final _cardWidth = size.width;
    final _cardHeight = size.height;
    const double _cardBorderRadius = 30;

    // path.
    final _path = Path()
      // 시작 지점으로 이동.
      ..moveTo(0, _cardBorderRadius)

      // 왼쪽 하단으로 라인.
      ..lineTo(0, _cardHeight - _cardBorderRadius)
      ..quadraticBezierTo(0, _cardHeight, _cardBorderRadius, _cardHeight)

      // 들어가는 부분.
      ..lineTo(50, _cardHeight)
      ..quadraticBezierTo(60, _cardHeight, 70, _cardHeight - 5)
      ..lineTo(90, _cardHeight - 15)
      ..quadraticBezierTo(100, _cardHeight - 20, 110, _cardHeight - 15)
      ..lineTo(130, _cardHeight - 5)
      ..quadraticBezierTo(140, _cardHeight, 150, _cardHeight)

      // 오른쪽 하단으로 라인.
      ..lineTo(_cardWidth - _cardBorderRadius, _cardHeight)
      ..quadraticBezierTo(_cardWidth, _cardHeight, _cardWidth, _cardHeight - _cardBorderRadius)

      // 오른쪽 상단으로 라인.
      ..lineTo(_cardWidth, _cardBorderRadius)
      ..quadraticBezierTo(_cardWidth, 0, _cardWidth - _cardBorderRadius, 0)

      // 왼쪽 상단으로 라인.
      ..lineTo(_cardBorderRadius, 0)
      ..quadraticBezierTo(0, 0, 0, _cardBorderRadius);

    // paint 설정.
    final _paint = Paint()
      ..color = kPurple
      ..strokeWidth = 10
      ..style = PaintingStyle.fill;

    // 그리기.
    canvas.drawPath(_path, _paint);
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(CardPainter oldDelegate) => false;
}
