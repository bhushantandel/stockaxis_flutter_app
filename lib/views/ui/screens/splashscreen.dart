import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stockaxis_flutter_app/views/shared/constants/app_colors.dart';
import 'package:stockaxis_flutter_app/views/ui/screens/pricingscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer t;

  @override
  void initState() {
    super.initState();

    t = Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const PricingScreen(),
          ));
    });
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color_white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/splash_screen_logo.png',
              height: 120,
              width: 120,
            ),
          ],
        ),
      ),
    );
  }
}
