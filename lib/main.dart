import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/intro_splash.dart'; // ✅ ubah path karena file ada langsung di folder lib
import 'login_page.dart'; // Langsung import login saja


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Atur tampilan status bar & system UI
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // menyatu dengan background
    statusBarIconBrightness: Brightness.dark, // ikon status bar gelap
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF22C55E),
          brightness: Brightness.light,
        ),
        fontFamily: 'Poppins', // ✅ font konsisten
      ),
      home: const IntroSplash(), // ✅ halaman splash baru dengan efek fade-in
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
