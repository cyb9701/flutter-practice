import 'package:flutter/material.dart';

class TossLogo extends StatelessWidget {
  const TossLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white38,
            Colors.black38,
          ],
        ).createShader(
          Rect.fromCenter(
            center: Offset(bounds.width / 2, bounds.height * 0.7),
            width: bounds.width,
            height: bounds.height,
          ),
        );
      },
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
