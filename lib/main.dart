import 'package:flutter/material.dart';

import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const FoodieHubApp());
}

class FoodieHubApp extends StatelessWidget {
  const FoodieHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodieHub',
      debugShowCheckedModeBanner: false,

      // Application-wide theme
      theme: AppTheme.lightTheme,

      // First screen of the application
      home: const SplashScreen(),
    );
  }
}