import 'package:card_gradient/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MastercardLogo extends StatelessWidget {
  const MastercardLogo({Key? key}) : super(key: key);

  // size.
  static const double _width = 120;
  static const double _height = 80;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 마스터카드 로고.
        SizedBox(
          width: _width,
          height: _height,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              // 그라데이션 배경.
              Positioned(
                top: 0,
                left: 0,
                child: _gradientCircle(),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: _gradientCircle(),
              ),

              CustomPaint(
                size: const Size(_width, _height),
                painter: MasterCardPainter(),
              ),
            ],
          ),
        ),

        // 마스터카드 텍스트.
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.grey.shade600,
              Colors.grey,
            ],
          ).createShader(
            Rect.fromCenter(
              width: bounds.width,
              height: bounds.height,
              center: Offset(bounds.width / 2, bounds.height / 2),
            ),
          ),
          child: const Text(
            'mastercard',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }

  // 테두리 그라데이션.
  ClipRRect _gradientCircle() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          gradient: SweepGradient(
            colors: Colors.accents,
          ),
        ),
      ),
    );
  }
}
