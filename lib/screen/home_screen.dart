import 'package:flutter/material.dart';

import '../switch_animation/switch_animation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffdddddd),
      body: Container(
        alignment: Alignment.center,
        child: SwitchAnimationWidget(
          defaultValue: false,
          onChanged: (value) {},
          width: 290,
          height: 100,
          spacing: 10,
          duration: 2000,
          waveCount: 3,
          waveSpacing: 20,
          radius: 200,
        ),
      ),
    );
  }
}
