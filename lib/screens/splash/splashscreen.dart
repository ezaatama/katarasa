import 'package:flutter/material.dart';
import 'package:katarasa/utils/constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUI.BACKGROUND_COLOR,
      body: Container(
        margin: const EdgeInsets.all(50),
        child: Center(
          child: Image.asset("assets/images/logokatarasa.png",
              fit: BoxFit.contain),
        ),
      ),
    );
  }
}
