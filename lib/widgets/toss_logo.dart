import 'package:flutter/material.dart';

class TossLogo extends StatelessWidget {
  const TossLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.black12,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(bounds.width, bounds.height / 2),
          radius: 30,
        ),
      ),
      child: const Text(
        'toss bank',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
