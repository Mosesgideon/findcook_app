import 'package:find_cook/features/dash_board/screens/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../authentication/presentation/screens/signin.dart';
import 'onboarding.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();


    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (ctx) =>  OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/png/logo.png",
          height: 200,
        ),
      ),
    );
  }
}
