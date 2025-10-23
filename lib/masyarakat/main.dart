import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_page.dart';
import 'screens/dashboard_page.dart';
import 'screens/hitung_emisi_page.dart';

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
      // SplashScreen dulu → ke LoginPage
      home: SplashScreen(nextPage: const LoginPage()),

      // 🧭 Daftar rute (biar mudah navigasi)
      routes: {
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/hitungEmisi': (context) => const HitungEmisiPage(),
      },
    );
  }
}
