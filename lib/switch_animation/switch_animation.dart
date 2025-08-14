import 'package:flutter/material.dart';
import 'package:testconcung/switch_animation/constanst/color.dart';
import 'package:testconcung/switch_animation/constanst/image_asset.dart';

import 'widget/box_container.dart';
import 'widget/dot.dart';

class SwitchAnimationWidget extends StatefulWidget {
  const SwitchAnimationWidget({
    this.onChanged,
    this.defaultValue,
    this.width,
    this.height,
    this.duration,
    this.radius,
    this.spacing,
    this.waveCount,
    this.waveSpacing,
    super.key,
  })  : assert(height == null || height > 20, 'Height cannot be less than 20'),
        assert(width == null || height == null || width > height,
            "Width can not be less than height");

  final double? width;
  final double? height;
  final int? duration;
  final double? radius;
  final double? spacing;
  final bool? defaultValue;
  final ValueChanged<bool>? onChanged;
  final int? waveCount;
  final double? waveSpacing;

  @override
  State<SwitchAnimationWidget> createState() => _SwitchAnimationWidgetState();
}

class _SwitchAnimationWidgetState extends State<SwitchAnimationWidget>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  final int _duration = 2000;
  double _widthSwitch = 350;
  double _heightSwitch = 145;
  double _radius = 200;
  double _paddingSwitch = 16;
  int _waveCount = 3;
  double _waveSpacing = 30;

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
    _widthSwitch = widget.width ?? _widthSwitch;
    _heightSwitch = widget.height ?? _heightSwitch;
    _paddingSwitch = widget.spacing ?? _paddingSwitch;
    _radius = widget.radius ?? _radius;
    _waveCount = widget.waveCount ?? _waveCount;
    _waveSpacing = widget.waveSpacing ?? _waveSpacing;

    controller = AnimationController(
      duration: Duration(milliseconds: widget.duration ?? _duration),
      vsync: this,
    );

    animation = TweenSequence([
      TweenSequenceItem(
        tween:
            Tween(begin: 0.0, end: -k).chain(CurveTween(curve: Curves.linear)),
        weight: 9,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -k, end: 1.0 + k)
            .chain(CurveTween(curve: Curves.linear)),
        weight: 20,
      ),
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
    _tweenClouds = Tween<double>(
        begin: -(_paddingSwitch), end: -_heightSwitch - _paddingSwitch);
    _tweenMoon = Tween<double>(begin: 1.5, end: 0);
    _tweenSwitchColor = ColorTween(
      begin: SwitchColor.sunBackgroundSwitch,
      end: SwitchColor.moonBackgroundSwitch,
    );
    _tweenStars = Tween<double>(begin: -_heightSwitch, end: 0);
    if (_value) {
      controller.forward();
    }
  }

  @override
  void didUpdateWidget(covariant SwitchAnimationWidget oldWidget) {
    if (widget.width != oldWidget.width) {
      _widthSwitch = widget.width ?? _widthSwitch;
    }
    if (widget.height != oldWidget.height) {
      _heightSwitch = widget.height ?? _heightSwitch;
      _tweenClouds = Tween<double>(
          begin: -(_paddingSwitch), end: -_heightSwitch - _paddingSwitch);
      _tweenStars = Tween<double>(begin: -_heightSwitch, end: 0);
    }
    if (widget.spacing != oldWidget.spacing) {
      _paddingSwitch = widget.spacing ?? _paddingSwitch;
    }
    if (widget.radius != oldWidget.radius) {
      _radius = widget.radius ?? _radius;
    }
    if (widget.waveCount != oldWidget.waveCount) {
      _waveCount = widget.waveCount ?? _waveCount;
    }
    if (widget.waveSpacing != oldWidget.waveSpacing) {
      _waveSpacing = widget.waveSpacing ?? _waveSpacing;
    }
    if (widget.duration != oldWidget.duration) {
      controller.duration =
          Duration(milliseconds: widget.duration ?? _duration);
    }
    if (widget.defaultValue != oldWidget.defaultValue) {
      onTapSwitch();
    }
    super.didUpdateWidget(oldWidget);
  }

  void onTapSwitch() {
    try {
      if (controller.isAnimating) {
        return;
      }
      _value = !_value;
      widget.onChanged?.call(_value);
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
    return InkWell(
      onTap: () {
        onTapSwitch();
      },
      borderRadius: BorderRadius.circular(_radius),
      hoverDuration: const Duration(seconds: 1),
      hoverColor: SwitchColor.hoverColor,
      child: AnimatedSwitch(
        animation: animation,
        key: UniqueKey(),
        width: _widthSwitch,
        height: _heightSwitch,
        radius: _radius,
        spacing: _paddingSwitch,
        waveCount: _waveCount,
        waveSpacing: _waveSpacing,
        tweenSunTween: _tweenSunTween,
        tweenClouds: _tweenClouds,
        tweenStars: _tweenStars,
        tweenMoon: _tweenMoon,
        tweenSwitchColor: _tweenSwitchColor,
      ),
    );
  }
}

class AnimatedSwitch extends AnimatedWidget {
  final double height;
  final double width;
  final double radius;
  final double spacing;
  final int waveCount;
  final double waveSpacing;
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
    required this.waveCount,
    required this.waveSpacing,
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

    return SwitchBoxContainer(
      width: width,
      height: height,
      radius: radius,
      color: tweenSwitchColor.evaluate(animation),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: tweenClouds.evaluate(animation), //- spacing / 2,
            child: SizedBox(
              height: height + spacing,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    ImageAsset.cloudBack,
                    fit: BoxFit.fill,
                    width: width,
                    height: height + spacing,
                  ),
                  Image.asset(
                    ImageAsset.cloudFront,
                    fit: BoxFit.fill,
                    width: width,
                    height: height + spacing,
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
                ImageAsset.starts,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            left: spacing,
            right: spacing - 4,
            child: Align(
              alignment: tweenSunTween.evaluate(animation),
              child: SwitchDotWidget(
                size: dotSize,
                animation: animation,
                moonTween: tweenMoon,
                waveCount: waveCount,
                waveSpacing: waveSpacing,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
