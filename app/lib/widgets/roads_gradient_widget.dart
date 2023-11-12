import 'package:flutter/material.dart';

class RoadsGradient extends StatelessWidget {
  const RoadsGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, Colors.transparent],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      blendMode: BlendMode.dstIn,
      child: Image.asset(
        'assets/images/roads.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
