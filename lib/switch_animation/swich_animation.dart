import 'package:flutter/material.dart';

import 'components/dot.dart';

class SwichAnimationWidget extends StatefulWidget {
  const SwichAnimationWidget({
    required this.onChanged,
    this.defaultValue,
    this.width,
    this.height,
    this.duration,
    this.radius,
    this.spacing,
    super.key,
  }) : assert(height != null && (height > 20), 'Height cannot be less than 20');

  final double? width;
  final double? height;
  final int? duration;
  final double? radius;
  final double? spacing;
  final bool? defaultValue;
  final ValueChanged<bool> onChanged;

  @override
  State<SwichAnimationWidget> createState() => _SwichAnimationWidgetState();
}

class _SwichAnimationWidgetState extends State<SwichAnimationWidget>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  double widthSwich = 350;
  double heightSwich = 145;
  double radius = 200;
  double paddingSwich = 16;
  int duration = 2000;

  late Tween<Alignment> _tweenSunTween;
  late Tween<double> _tweenClouds;
  late Tween<double> _tweenMoon;
  late ColorTween _tweenSwitchColor;
  late Tween<double> _tweenStars;
  static const double k = 0.05;

  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.defaultValue ?? false;
    widthSwich = widget.width ?? widthSwich;
    heightSwich = widget.height ?? heightSwich;
    paddingSwich = widget.spacing ?? paddingSwich;
    radius = widget.radius ?? radius;

    controller = AnimationController(
      duration: Duration(milliseconds: widget.duration ?? duration),
      vsync: this,
    );

    animation = TweenSequence([
      TweenSequenceItem(
        tween:
            Tween(begin: 0.0, end: -k).chain(CurveTween(curve: Curves.linear)),
        weight: 9,
      ),
      // -k → 1 + k (đi hết hành trình, vượt qua đầu 1)
      TweenSequenceItem(
        tween: Tween(begin: -k, end: 1.0 + k)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 20,
      ),
      // 1 + k → 1.0 (trở về vị trí cuối)
      TweenSequenceItem(
        tween: Tween(begin: 1.0 + k, end: 1.0)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 9,
      ),
    ]).animate(controller);

    _tweenSunTween = Tween<Alignment>(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    _tweenClouds = Tween<double>(begin: 0, end: -heightSwich);
    _tweenMoon = Tween<double>(begin: 1.5, end: 0);
    _tweenSwitchColor = ColorTween(
      begin: const Color(0xff2384BA),
      end: const Color(0xFF2F2F2F),
    );
    _tweenStars = Tween<double>(begin: -heightSwich, end: 0);
    if (_value) {
      controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant SwichAnimationWidget oldWidget) {
    if (widget.width != oldWidget.width) {
      widthSwich = widget.width ?? widthSwich;
    }
    if (widget.height != oldWidget.height) {
      heightSwich = widget.height ?? heightSwich;
      _tweenClouds = Tween<double>(begin: 0, end: -heightSwich);
      _tweenStars = Tween<double>(begin: -heightSwich, end: 0);
    }
    if (widget.spacing != oldWidget.spacing) {
      paddingSwich = widget.spacing ?? paddingSwich;
    }
    if (widget.radius != oldWidget.radius) {
      radius = widget.radius ?? radius;
    }
    if (widget.duration != oldWidget.duration) {
      controller.duration = Duration(milliseconds: widget.duration ?? duration);
    }
    if (widget.defaultValue != oldWidget.defaultValue) {
      onTapSwich();
    }
    super.didUpdateWidget(oldWidget);
  }

  void onTapSwich() {
    try {
      if (controller.isAnimating) {
        return;
      }
      _value = !_value;
      widget.onChanged(_value);
      if (_value) {
        controller.forward();
      } else {
        controller.reverse();
      }
    } catch (e) {
      controller.stop();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdddddd),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  color: Colors.red,
                ),
                ...List.generate(3, (i) {
                  double index = i + 1;
                  return Positioned.fill(
                    top: -20 * index,
                    bottom: -20 * index,
                    left: -20 * index,
                    right: -20 * index,
                    child: Container(
                      color: Colors.black.withOpacity(.5),
                    ),
                  );
                })
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                onTapSwich();
              },
              borderRadius: BorderRadius.circular(radius),
              hoverDuration: const Duration(seconds: 1),
              hoverColor: Colors.amber,
              child: AnimatedSwitch(
                animation: animation,
                key: UniqueKey(),
                width: widthSwich,
                height: heightSwich,
                radius: radius,
                spacing: paddingSwich,
                tweenSunTween: _tweenSunTween,
                tweenClouds: _tweenClouds,
                tweenStars: _tweenStars,
                tweenMoon: _tweenMoon,
                tweenSwitchColor: _tweenSwitchColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedSwitch extends AnimatedWidget {
  final double height;
  final double width;
  final double radius;
  final double spacing;
  final Tween<Alignment> tweenSunTween;
  final Tween<double> tweenClouds;
  final Tween<double> tweenStars;
  final Tween<double> tweenMoon;
  final ColorTween tweenSwitchColor;

  const AnimatedSwitch({
    super.key,
    required Animation<double> animation,
    required this.height,
    required this.width,
    required this.radius,
    required this.spacing,
    required this.tweenSunTween,
    required this.tweenClouds,
    required this.tweenStars,
    required this.tweenMoon,
    required this.tweenSwitchColor,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final double dotSize = height - spacing;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 1.5),
            blurRadius: 90,
            spreadRadius: 0,
            color: const Color(0xff000000).withOpacity(0.85),
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            offset: const Offset(-1, -1),
            blurRadius: 12,
            spreadRadius: 0,
            color: const Color(0xff000000).withOpacity(0.4),
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            offset: const Offset(2.2, 6),
            blurRadius: 2,
            spreadRadius: 0,
            color: const Color(0xffFFFFFF).withOpacity(0.72),
            blurStyle: BlurStyle.normal,
          ),
          BoxShadow(
            offset: const Offset(-0.5, -5),
            blurRadius: 2,
            spreadRadius: 0,
            color: const Color(0xff000000).withOpacity(0.25),
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: tweenSwitchColor.evaluate(animation),
            ),
            Positioned(
              bottom: tweenClouds.evaluate(animation) - spacing / 2,
              child: SizedBox(
                height: height,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(
                      "assets/images/img-clouds-backs.png",
                      fit: BoxFit.fill,
                      width: width,
                      height: height,
                    ),
                    Image.asset(
                      "assets/images/img-clouds.png",
                      fit: BoxFit.fill,
                      width: width,
                      height: height,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: spacing * 2,
              top: tweenStars.evaluate(animation) + spacing / 2,
              child: SizedBox(
                width: height + spacing,
                height: height - spacing,
                child: Image.asset(
                  "assets/images/img-stars.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              left: spacing,
              right: spacing - 4,
              child: Align(
                alignment: tweenSunTween.evaluate(animation),
                child: DotWidget(
                  size: dotSize,
                  animation: animation,
                  moonTween: tweenMoon,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
