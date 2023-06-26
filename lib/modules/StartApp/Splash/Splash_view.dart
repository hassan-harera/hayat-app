import 'package:flutter/material.dart';

import 'SplashBody.dart';
class splashView extends StatelessWidget{
  const splashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: splashBody()
    );
  }
}