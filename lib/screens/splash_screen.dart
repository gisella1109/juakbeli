import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // ✅ untuk font poppins

class SplashScreen extends StatefulWidget {
  final Widget nextPage; // halaman tujuan setelah splash
  const SplashScreen({super.key, required this.nextPage});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
  late final Animation<double> _fade = CurvedAnimation(parent: _ac, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    _ac.forward();
    // Auto masuk ke halaman utama setelah delay
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => widget.nextPage,
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    });
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shortest = MediaQuery.of(context).size.shortestSide;
    final logoSize = shortest * 0.28; // responsive logo size

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fade,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 🖼️ Logo
                Image.asset(
                  'assets/splash/logo.png',
                  width: logoSize,
                  height: logoSize,
                ),
                const SizedBox(height: 24),
                // 🪴 Judul utama
                Text(
                  'I-TransEC',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700, // Bold
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                // 🌱 Tagline
                Text(
                  'Hitung Emisimu Selamatkan Bumi',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500, // Medium
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
