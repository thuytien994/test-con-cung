import 'package:flutter/material.dart';

class SwitchBoxContainer extends StatelessWidget {
  const SwitchBoxContainer({
    required this.width,
    required this.height,
    required this.radius,
    required this.color,
    required this.child,
    super.key,
  });

  final double width;
  final double height;
  final double radius;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
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
            color: const Color(0xff000000).withOpacity(0.49),
            blurStyle: BlurStyle.inner,
          ),
          BoxShadow(
            offset: const Offset(2.2, 6),
            blurRadius: 2,
            spreadRadius: 0,
            color: const Color(0xffFFFFFF).withOpacity(0.79),
            blurStyle: BlurStyle.normal,
          ),
          BoxShadow(
            offset: const Offset(-0.5, -5.5),
            blurRadius: 2,
            spreadRadius: 0,
            color: const Color(0xff000000).withOpacity(0.25),
            blurStyle: BlurStyle.normal,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}
