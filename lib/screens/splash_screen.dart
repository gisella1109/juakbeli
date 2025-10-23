import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextPage; // 👈 Tambahkan properti untuk halaman berikutnya

  const SplashScreen({super.key, required this.nextPage}); // 👈 Konstruktor wajib

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
void initState() {
  super.initState();
  Future.delayed(const Duration(seconds: 3), () {
    if (!mounted) return; // ✅ Tambahkan baris ini
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget.nextPage),
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_android12.png', height: 120),
            const SizedBox(height: 20),
            const CircularProgressIndicator(color: Colors.green),
            const SizedBox(height: 10),
            const Text(
              'Memuat...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
