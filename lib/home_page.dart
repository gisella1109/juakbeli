import 'package:flutter/material.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("I-TransEc - Dashboard"),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text(
          "Selamat datang di I-TransEc!\nHitung emisi karbonmu di sini 🌱",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
