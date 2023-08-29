import 'package:flutter/material.dart';
import 'package:katarasa/utils/cache_storage.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/network.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _loadData() async {
    final NavigatorState navigator = Navigator.of(context);

    String token = CacheStorage.getTokenApi();
    debugPrint('tokened: $token');
    if (token != '') {
      initTokenHeader(token);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 1, milliseconds: 30), () {
          navigator.pushReplacementNamed('/home');
        });
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(seconds: 1, milliseconds: 30), () {
          navigator.pushReplacementNamed('/login');
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
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
