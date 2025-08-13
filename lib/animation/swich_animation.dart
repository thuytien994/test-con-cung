import 'package:flutter/material.dart';

class SwichAnimationWidget extends StatefulWidget {
  const SwichAnimationWidget({super.key});

  @override
  State<SwichAnimationWidget> createState() => _SwichAnimationWidgetState();
}

class _SwichAnimationWidgetState extends State<SwichAnimationWidget>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  var isOpenBlack = ValueNotifier<bool>(false);
  var statusAnimation = ValueNotifier<AnimationStatus?>(null);
  double widthSwich = 350;
  double heightSwich = 145;
  late Tween<double> _tweenSunTween;
  late Tween<double> _tweenClouds;
  late Tween<double> _tweenMoon;
  final _tweenStars = Tween<double>(begin: -145, end: 30);
  double paddingSwich = 16;
  static const double k = 0.05;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    animation = TweenSequence([
      // TweenSequenceItem(
      //   tween: Tween(begin: 0.0, end: 1.05)
      //       .chain(CurveTween(curve: Curves.easeOut)),
      //   weight: 20,
      // ),
      // TweenSequenceItem(
      //   tween: Tween(begin: 1.05, end: 1.0)
      //       .chain(CurveTween(curve: Curves.easeOut)),
      //   weight: 6,
      // ),
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
    ]).animate(controller)
      ..addStatusListener(
        (status) {
          statusAnimation.value = status;
        },
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _tweenSunTween = Tween<double>(begin: -40, end: 164);
    _tweenClouds = Tween<double>(begin: 0, end: -heightSwich);
    _tweenMoon = Tween<double>(begin: -(widthSwich / 2), end: 0);
  }

  void onTapSwich() {
    if (statusAnimation.value == AnimationStatus.completed) {
      controller.reverse();
      return;
    } else if (statusAnimation.value == AnimationStatus.dismissed) {
      controller.forward();
      return;
    }
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdddddd),
      body: Container(
        alignment: Alignment.center,
        child: ValueListenableBuilder(
            valueListenable: isOpenBlack,
            builder: (context, value, _) {
              return InkWell(
                onTap: () {
                  onTapSwich();
                },
                onHover: (value) {
                  print("here aaaaaaa:$value");
                },
                hoverDuration: Duration(seconds: 1),
                hoverColor: Colors.amber,
                child: AnimatedLogo(
                  animation: animation,
                  status: statusAnimation.value,
                  key: UniqueKey(),
                  width: widthSwich,
                  height: heightSwich,
                  tweenSunTween: _tweenSunTween,
                  tweenClouds: _tweenClouds,
                  tweenStars: _tweenStars,
                  tweenMoon: _tweenMoon,
                ),
              );
            }),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  final AnimationStatus? status;
  final double height;
  final double width;
  final Tween<double>? tweenSunTween;
  final Tween<double>? tweenClouds;
  final Tween<double>? tweenStars;
  final Tween<double>? tweenMoon;
  const AnimatedLogo({
    super.key,
    required Animation<double> animation,
    this.status,
    required this.height,
    required this.width,
    this.tweenSunTween,
    this.tweenClouds,
    this.tweenStars,
    this.tweenMoon,
  }) : super(listenable: animation);

  static final _tweenOpacityBackground = Tween<double>(begin: 0, end: 1);
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
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
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff2384BA),
          borderRadius: BorderRadius.circular(200),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(200),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity:
                    _tweenOpacityBackground.evaluate(animation).clamp(0.0, 1),
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: const Color(0xff2384BA),
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: Stack(
                      children: [
                        Container(
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: const Color(0xff2F2F2F)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              if (tweenClouds != null)
                Positioned(
                  bottom: tweenClouds?.evaluate(animation),
                  child: SizedBox(
                    width: width,
                    height: height,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset(
                          "assets/images/img-clouds-backs.png",
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          "assets/images/img-clouds.png",
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              if (tweenStars != null)
                Positioned(
                  left: 40,
                  top: tweenStars?.evaluate(animation),
                  child: SizedBox(
                    width: 142,
                    height: 93,
                    child: Image.asset("assets/images/img-stars.png"),
                  ),
                ),
              Positioned(
                left: tweenSunTween?.evaluate(animation),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          shape: BoxShape.circle),
                      child: Container(
                        height: height - 20,
                        width: height - 20,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/images/img-sun.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(200),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Positioned(
                                right: tweenMoon?.evaluate(animation),
                                child: Image.asset(
                                  "assets/images/img-moon.png",
                                  height: height - 20,
                                  width: height - 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
