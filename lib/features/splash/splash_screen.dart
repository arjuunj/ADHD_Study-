import 'dart:async';
import 'package:flutter/material.dart';
import '../auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Or use theme color
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          fit: BoxFit
              .contain, // Adjust based on user's "entire screen" preference, but contain is safer for logos
          width: MediaQuery.of(context).size.width * 0.8, // 80% of screen width
        ),
      ),
    );
  }
}
