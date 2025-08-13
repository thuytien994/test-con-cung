import 'package:flutter/material.dart';
import 'package:testconcung/switch_animation/constanst/image_asset.dart';

class DotWidget extends StatelessWidget {
  const DotWidget({
    required this.size,
    required this.animation,
    required this.moonTween,
    required this.waveCount,
    required this.waveSpacing,
    super.key,
  });

  final double size;
  final Animation<double> animation;
  final Tween<double> moonTween;
  final int waveCount;
  final double waveSpacing;

  @override
  Widget build(BuildContext context) {
    return _Wave(
      size: size,
      waveCount: waveCount,
      waveSpacing: waveSpacing,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2000),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: size,
              width: size,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(ImageAsset.sun),
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
                  ImageAsset.moon,
                  height: size,
                  width: size,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Wave extends StatelessWidget {
  const _Wave({
    required this.child,
    required this.size,
    this.waveCount = 3,
    this.waveSpacing = 30,
  });

  final Widget child;
  final double size;
  final int waveCount;
  final double waveSpacing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox.square(
          dimension: size,
        ),
        ...List.generate(waveCount, (i) {
          final double number = i + 1;
          return Positioned.fill(
            top: -waveSpacing * number,
            bottom: -waveSpacing * number,
            left: -waveSpacing * number,
            right: -waveSpacing * number,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(.1),
              ),
            ),
          );
        }),
        Positioned.fill(child: child),
      ],
    );
  }
}
