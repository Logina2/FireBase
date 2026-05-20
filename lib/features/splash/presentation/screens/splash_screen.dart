import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iti_cu/core/resource/app_text_styles.dart';
import 'package:iti_cu/core/services/firebase_auth_service.dart';
import 'package:iti_cu/features/auth/presentation/screens/login_screen.dart';
import 'package:iti_cu/features/main/presentation/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (FirebaseAuthService.getCurrentUser() == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Chat App', style: AppTextStyles.grey20Bold)),
    );
  }
}
