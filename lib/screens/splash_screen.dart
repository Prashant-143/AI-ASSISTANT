import 'package:ai_assistant/helper/pref.dart';
import 'package:ai_assistant/screens/home_screen.dart';
import 'package:ai_assistant/screens/onboarding_screen.dart';
import 'package:get/get.dart';

import '../helper/global.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() =>
          Pref.showOnboarding ? const OnboardingScreen() : const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing device size
    mq = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Center(
        child: Card(
          color: Colors.blue,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Padding(
            padding: EdgeInsets.all(mq.width * 0.0),
            child: Image.asset(
              'assets/images/AI_LOGO.png',
              width: mq.width * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}
