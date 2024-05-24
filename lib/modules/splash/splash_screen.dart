// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pro/component/shared_pref.dart';
import 'package:pro/layouts/home_layout.dart';
import 'package:pro/modules/login_and_register/login_page.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  Future<void> navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool isLoggedIn = await SharedPreferencesHelper.getLoginState();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/splash_dark.png',
        fit: BoxFit.fitHeight,
      ),
      backgroundColor: const Color(0xff060E1E),
    );
  }
}
