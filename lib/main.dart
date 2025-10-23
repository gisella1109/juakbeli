import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/splash_screen.dart';
import 'login_page.dart'; // Langsung import login saja

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Hilangkan native splash screen secepat mungkin
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  
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
      home: const LoginPage(), // Langsung ke login, skip splash Flutter
    );
  }
}