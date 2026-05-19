import 'package:flutter/material.dart';
import 'package:iti_cu/app/navigation_key.dart';
import 'package:iti_cu/core/resource/app_colors.dart';
import 'package:iti_cu/features/splash/presentation/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigationKey.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.primary,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.grey),
          centerTitle: false,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
