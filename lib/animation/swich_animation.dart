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
  var widthSwich = 350;
  var statusAnimation = ValueNotifier<AnimationStatus?>(null);
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        statusAnimation.value = status;
      });
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
      body: Container(
        // color: const Color(0xffdddddd),
        color: Colors.white,
        alignment: Alignment.center,
        child: ValueListenableBuilder(
            valueListenable: isOpenBlack,
            builder: (context, value, _) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      onTapSwich();
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      // width: 350,
                      // height: 145,
                      // decoration: BoxDecoration(
                      //     color: const Color(0xff2384BA),
                      //     borderRadius: BorderRadius.circular(200),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         blurStyle: BlurStyle.inner,
                      //         spreadRadius: 0,
                      //         offset: const Offset(1, 5),
                      //         blurRadius: 9,
                      //         color: const Color(0xff000000).withOpacity(0.25),
                      //       ),
                      //       BoxShadow(
                      //         blurStyle: BlurStyle.inner,
                      //         spreadRadius: 0,
                      //         offset: const Offset(0, -1),
                      //         blurRadius: 12,
                      //         color: const Color(0xff000000).withOpacity(0.25),
                      //       ),
                      //     ]),
                      child: AnimatedLogo(
                        animation: animation,
                        status: statusAnimation.value,
                        isOpenBlack: value,
                        key: UniqueKey(),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  bool isOpenBlack;
  AnimationStatus? status;
  AnimatedLogo({
    super.key,
    required Animation<double> animation,
    required this.isOpenBlack,
    this.status,
  }) : super(listenable: animation);

  static final _tweenSunTween = Tween<double>(begin: 8, end: 218);
  static final _tweenClouds = Tween<double>(begin: 0, end: -145);
  static final _tweenStars = Tween<double>(begin: -145, end: 30);
  static final _tweenMoon = Tween<double>(begin: -132, end: 0);
  static final _tweenOpacityBackground = Tween<double>(begin: 0, end: 1);
  static final _tweenRays = Tween<double>(begin: -205, end: 0);
  // static final _tweenOpacityBackground = Tween<double>(begin: 0, end: 0);
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Container(
      width: 350,
      height: 145,
      decoration: BoxDecoration(
          color: const Color(0xff2384BA),
          borderRadius: BorderRadius.circular(200),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.inner,
              spreadRadius: 0,
              offset: const Offset(1, 5),
              blurRadius: 9,
              color: const Color(0xff000000).withOpacity(0.25),
            ),
            BoxShadow(
              blurStyle: BlurStyle.inner,
              spreadRadius: 0,
              offset: const Offset(0, -1),
              blurRadius: 12,
              color: const Color(0xff000000).withOpacity(0.25),
            ),
          ]),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          Opacity(
            opacity: _tweenOpacityBackground.evaluate(animation),
            child: Container(
              width: 350,
              height: 145,
              decoration: BoxDecoration(
                color: const Color(0xff2384BA),
                borderRadius: BorderRadius.circular(200),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: Stack(
                  children: [
                    Container(
                      width: 350,
                      height: 145,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: const Color(0xff2F2F2F)),
                    )
                  ],
                ),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: _tweenSunTween.evaluate(animation),
                child: Container(
                    height: 132,
                    width: 132,
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
                        children: [
                          Positioned(
                            right: _tweenMoon.evaluate(animation),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                "assets/images/img-moon.png",
                                height: 132,
                                width: 132,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Positioned(
                left: _tweenRays.evaluate(animation),
                child: Image.asset(
                  "assets/images/img-rays.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Positioned(
            bottom: _tweenClouds.evaluate(animation),
            child: SizedBox(
              width: 350,
              height: 145,
              child: Stack(
                alignment: Alignment.bottomCenter,
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/img-clouds-backs.png",
                    fit: BoxFit.fill,
                  ),
                  Image.asset(
                    "assets/images/img-clouds.png",
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: _tweenStars.evaluate(animation),
            child: SizedBox(
              width: 142,
              height: 93,
              child: Image.asset("assets/images/img-stars.png"),
            ),
          )
        ],
      ),
    );
  }
}
