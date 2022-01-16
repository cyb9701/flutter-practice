import 'package:flutter/material.dart';
import 'dart:math' as math;

class MasterCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 지름.
    const double _diameter = 38 * 2;

    // paint.
    final _paint = Paint()..color = Colors.grey.shade400;

    // 왼쪽 원.
    final _leftPath = Path()
      ..arcTo(
        Rect.fromCenter(
          center: const Offset(40, 40),
          width: _diameter,
          height: _diameter,
        ),
        math.pi / 2.9,
        math.pi * 1.28,
        false,
      )
      ..arcTo(
        Rect.fromCenter(
          center: const Offset(80, 40),
          width: _diameter + 4,
          height: _diameter + 4,
        ),
        -math.pi / 1.45,
        -math.pi * 0.63,
        false,
      );
    canvas.drawPath(_leftPath, _paint);

    // 오른쪽 원.
    final _rightPath = Path()
      ..arcTo(
        Rect.fromCenter(
          center: const Offset(80, 40),
          width: _diameter,
          height: _diameter,
        ),
        -math.pi / 1.52,
        math.pi * 1.28,
        false,
      )
      ..arcTo(
        Rect.fromCenter(
          center: const Offset(40, 40),
          width: _diameter + 4,
          height: _diameter + 4,
        ),
        math.pi / 3.2,
        -math.pi * 0.63,
        false,
      );
    canvas.drawPath(_rightPath, _paint);

    // 가운데 원.
    final _centerPath = Path()
      ..arcTo(
        Rect.fromCenter(
          center: const Offset(40, 40),
          width: _diameter,
          height: _diameter,
        ),
        -math.pi / 3.1,
        math.pi * 0.63,
        false,
      )
      ..arcTo(
        Rect.fromCenter(center: const Offset(80, 40), width: _diameter, height: _diameter),
        math.pi / 1.48,
        math.pi * 0.65,
        false,
      );
    canvas.drawPath(_centerPath, _paint);
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(MasterCardPainter oldDelegate) => false;
}
