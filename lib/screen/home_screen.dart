import 'package:flutter/material.dart';

import '../switch_animation/swich_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdddddd),
      body: Container(
        alignment: Alignment.center,
        child: SwichAnimationWidget(
          defaultValue: false,
          onChanged: (value) {},
          width: 300,
          height: 100,
          spacing: 10,
          duration: 3000,
        ),
      ),
    );
  }
}
