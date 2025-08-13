import 'package:flutter/material.dart';
import 'package:testconcung/switch_animation/swich_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SwichAnimationWidget(
        defaultValue: false,
        onChanged: (value) {},
        width: 300,
        height: 100,
        spacing: 10,
        duration: 3000,
      ),
    );
  }
}
