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
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    animation = Tween<double>(begin: 0, end: 300).animate(controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addStatusListener((status) => print('$status'));
//    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xffdddddd),
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
                      isOpenBlack.value != isOpenBlack.value;
                      setState(() {});
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: 369,
                      height: 145,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color(0xff2384BA),
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
                      child: AnimatedLogo(
                        animation: animation,
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
  AnimatedLogo({
    super.key,
    required Animation<double> animation,
    required this.isOpenBlack,
  }) : super(listenable: animation);
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);
  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    print("here aaaaa: ");
    return Stack(
      alignment: Alignment.center,
      children: [
        isOpenBlack
            ? Positioned(
                right: 0,
                child: Image.asset(
                  "assets/images/img-moon.png",
                  height: 132,
                  width: 132,
                ),
              )
            : Positioned(
                top: 0,
                child: Image.asset(
                  "assets/images/img-sun.png",
                  height: 132,
                  width: 132,
                ),
              ),
      ],
    );
  }
}
