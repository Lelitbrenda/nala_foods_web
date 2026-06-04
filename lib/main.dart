import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'sections/landing_page.dart';

void main() {
  runApp(const NalaFoodsApp());
}

class NalaFoodsApp extends StatelessWidget {
  const NalaFoodsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nala Foods',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const LandingPage(),
    );
  }
}