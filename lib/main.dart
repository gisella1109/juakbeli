import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'home_page.dart'; 

void main() {
  runApp(const ITransecApp());
}

class ITransecApp extends StatelessWidget {
  const ITransecApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I-TransEC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF22C55E)),
        useMaterial3: true,
      ),
      home: SplashScreen(nextPage: const HomePage()), // 👈 arahkan ke halaman utama
    );
  }
}