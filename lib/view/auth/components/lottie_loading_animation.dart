import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class LottieLoadingAnimation extends StatelessWidget {
  const LottieLoadingAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/json/loading_animation.json',
      width: 70,
      height: 70,
      repeat: true,
    );
  }
}
