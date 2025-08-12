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

    // animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut)
    //   ..addStatusListener((status) {

    //   });
    animation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.1)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 80,
      ),
      TweenSequenceItem(
        tween:
            Tween(begin: 1.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 20,
      ),
    ]).animate(controller)
      ..addStatusListener(
        (status) {
          statusAnimation.value = status;
        },
      );
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
              return GestureDetector(
                onTap: () {
                  onTapSwich();
                },
                behavior: HitTestBehavior.opaque,
                child: AnimatedLogo(
                  animation: animation,
                  status: statusAnimation.value,
                  key: UniqueKey(),
                ),
              );
            }),
      ),
    );
  }
}

class AnimatedLogo extends AnimatedWidget {
  final AnimationStatus? status;
  const AnimatedLogo({
    super.key,
    required Animation<double> animation,
    this.status,
  }) : super(listenable: animation);

  static final _tweenSunTween = Tween<double>(begin: -40, end: 164);
  static final _tweenClouds = Tween<double>(begin: 0, end: -145);
  static final _tweenStars = Tween<double>(begin: -145, end: 30);
  static final _tweenMoon = Tween<double>(begin: -132, end: 0);
  static final _tweenOpacityBackground = Tween<double>(begin: 0, end: 1);
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
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 6,
              blurStyle: BlurStyle.normal,
            ),
            // Bóng ngoài (xám phía dưới bên phải)
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(4, 4),
              blurRadius: 6,
              blurStyle: BlurStyle.normal,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, -3),
              blurRadius: 6,
              blurStyle: BlurStyle.inner,
            ),
            // Inset shadow (sáng phía dưới)
            BoxShadow(
              color: Colors.white.withOpacity(0.8),
              offset: Offset(0, 3),
              blurRadius: 6,
              blurStyle: BlurStyle.inner,
            ),
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.passthrough,
          children: [
            Opacity(
              opacity: 1, //_tweenOpacityBackground.evaluate(animation),
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
            Positioned(
              bottom: _tweenClouds.evaluate(animation),
              child: SizedBox(
                width: 350,
                height: 145,
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
            Positioned(
              left: 50,
              top: _tweenStars.evaluate(animation),
              child: SizedBox(
                width: 142,
                height: 93,
                child: Image.asset("assets/images/img-stars.png"),
              ),
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: _tweenSunTween.evaluate(animation),
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
                    ),
                  ),
                ),
                // Positioned(
                //   left: _tweenRays.evaluate(animation),
                //   child: Image.asset(
                //     "assets/images/img-rays.png",
                //     height: 100,
                //     width: 100,
                //     fit: BoxFit.fill,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
