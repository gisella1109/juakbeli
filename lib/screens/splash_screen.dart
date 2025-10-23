import 'package:flutter/material.dart';
import '../login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 800),
  );
  late final Animation<double> _fade = CurvedAnimation(
    parent: _ac,
    curve: Curves.easeOut,
  );

  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _ac.forward();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    
    if (!mounted || _navigated) return;
    
    _navigated = true;
    
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // ← TAMBAH INI
        children: [
          // Logo dari assets dengan FadeTransition
          FadeTransition(
            opacity: _fade,
            child: Image.asset(
              'assets/splash/logo.png',
              width: 140,
              height: 140,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.eco, size: 140, color: Colors.green);
              },
            ),
          ),
          const SizedBox(height: 24),
          
          // Text "I-TransEC" dengan FadeTransition
          FadeTransition(
            opacity: _fade,
            child: const Text(
              'I-TransEC',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          
          // Subtitle dengan FadeTransition
          FadeTransition(
            opacity: _fade,
            child: const Text(
              'Hitung Emisimu Selamatkan Bumi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}