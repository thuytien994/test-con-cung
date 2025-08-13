import 'package:flutter/material.dart';

class DotWidget extends StatelessWidget {
  const DotWidget({
    required this.size,
    required this.animation,
    required this.moonTween,
    super.key,
  });

  final double size;
  final Animation<double> animation;
  final Tween<double> moonTween;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(1000),
      child: Stack(
        children: [
          Container(
            height: size,
            width: size,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage("assets/images/img-sun.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: moonTween.evaluate(animation) * size,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/img-moon.png",
                height: size,
                width: size,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
