import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BerandaPage(),
    const HitungEmisiPage(),
    const SimulasiPage(),
    const ProfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF4CAF50),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Hitung Emisi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Simulasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

//
// ===================== HALAMAN BERANDA =====================
//
class BerandaPage extends StatelessWidget {
  const BerandaPage({super.key});

  void _showArtikelPopup(BuildContext context, Map<String, String> artikel) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header dengan gambar
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      'assets/logo.png',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Konten artikel
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            artikel["judul"]!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B4332),
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            artikel["konten"]!,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Konten tambahan untuk artikel lengkap
                          Text(
                            _getArtikelLengkap(artikel["judul"]!),
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black87,
                              height: 1.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Tombol tutup
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4CAF50),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Tutup",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _getArtikelLengkap(String judul) {
    // Konten lengkap untuk setiap artikel
    switch (judul) {
      case "5 Cara Mudah Kurangi Jejak Karbon Harianmu":
        return "Untuk mengurangi jejak karbon, kamu bisa memulai dengan hal-hal sederhana. Pertama, gunakan transportasi umum atau bersepeda untuk aktivitas sehari-hari. Kedua, kurangi penggunaan plastik sekali pakai dengan membawa tas belanja dan botol minum sendiri.\n\nKetiga, matikan peralatan elektronik saat tidak digunakan untuk menghemat energi. Keempat, kurangi konsumsi daging merah dan perbanyak sayuran dalam menu harianmu. Kelima, dukung produk lokal untuk mengurangi emisi dari transportasi barang jarak jauh.";
      
      case "Kenapa Emisi Karbon Itu Penting?":
        return "Emisi karbon dioksida (CO₂) adalah salah satu penyebab utama perubahan iklim global. Gas ini terperangkap di atmosfer dan menyebabkan efek rumah kaca, yang mengakibatkan peningkatan suhu bumi.\n\nDampaknya sangat luas, mulai dari pencairan es di kutub, kenaikan permukaan air laut, hingga perubahan pola cuaca ekstrem. Dengan mengurangi emisi karbon, kita membantu memperlambat laju perubahan iklim dan menjaga planet ini tetap layak huni untuk generasi mendatang.";
      
      case "Tips Gaya Hidup Hijau untuk Pemula":
        return "Memulai gaya hidup hijau tidak harus sulit. Mulailah dengan menghemat energi di rumah dengan menggunakan lampu LED dan mencabut charger saat tidak dipakai. Kurangi sampah dengan menerapkan prinsip 3R: Reduce (kurangi), Reuse (gunakan kembali), dan Recycle (daur ulang).\n\nBelanja produk lokal dan organik juga membantu mengurangi jejak karbon. Jangan lupa untuk memilah sampah dan membuat kompos dari sisa makanan. Setiap langkah kecil yang kamu lakukan akan memberikan dampak besar bagi lingkungan.";
      
      case "Transportasi Ramah Lingkungan":
        return "Transportasi adalah salah satu kontributor terbesar emisi karbon. Untuk menguranginya, pertimbangkan untuk bersepeda atau berjalan kaki untuk jarak dekat. Selain menyehatkan, aktivitas ini juga tidak menghasilkan emisi.\n\nUntuk jarak yang lebih jauh, gunakan transportasi umum seperti bus, kereta, atau MRT. Jika harus menggunakan kendaraan pribadi, pertimbangkan carpooling atau beralih ke kendaraan listrik. Dengan memilih transportasi ramah lingkungan, kamu turut berkontribusi mengurangi polusi udara dan emisi karbon.";
      
      default:
        return "Baca artikel lengkapnya untuk mendapatkan informasi lebih detail tentang topik ini.";
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> artikelList = [
      {
        "judul": "5 Cara Mudah Kurangi Jejak Karbon Harianmu",
        "konten":
            "Mulai dari menggunakan transportasi umum, membawa botol minum sendiri, hingga mengurangi konsumsi daging merah."
      },
      {
        "judul": "Kenapa Emisi Karbon Itu Penting?",
        "konten":
            "Emisi karbon mempengaruhi perubahan iklim. Dengan menguranginya, kita ikut menjaga bumi agar tetap layak huni."
      },
      {
        "judul": "Tips Gaya Hidup Hijau untuk Pemula",
        "konten":
            "Gunakan energi terbarukan, matikan listrik saat tidak dipakai, dan belanja produk lokal ramah lingkungan."
      },
      {
        "judul": "Transportasi Ramah Lingkungan",
        "konten":
            "Bersepeda, berjalan kaki, dan naik kendaraan umum membantu menurunkan emisi karbon dari aktivitas harianmu."
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Yuk, pantau dan kurangi emisi kamu tiap hari 🌱",
                style: TextStyle(fontSize: 15, color: Color(0xFF2D6A4F)),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Total Emisi Bulan Ini",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black54,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "1 Kg",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 4),
                        Padding(
                          padding: EdgeInsets.only(bottom: 3),
                          child: Text(
                            "CO₂",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.1,
                        backgroundColor: const Color(0xFFE5F2E9),
                        color: const Color(0xFF4CAF50),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Naik 5% dari bulan lalu 📈",
                      style: TextStyle(color: Colors.black45, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4CAF50).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.eco, color: Colors.white, size: 24),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "Kamu menghemat emisi di bulan ini, kerja bagus!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Terus pertahankan gaya hidup ramah lingkunganmu!",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF4CAF50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Lihat Tips",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Mulai Perjalanan Baru",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // ===================== ARTIKEL DI BAWAH MULAI PERJALANAN =====================
              const SizedBox(height: 32),
              const Text(
                "Artikel Terbaru",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: artikelList.map((artikel) {
                  return GestureDetector(
                    onTap: () => _showArtikelPopup(context, artikel),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Gambar di kiri (lebih kecil)
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            child: Image.asset(
                              'assets/logo.png',
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Konten artikel
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    artikel["judul"]!,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    artikel["konten"]!,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black54,
                                      height: 1.4,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
// ===================== HALAMAN LAIN (SIMPLE DUMMY) =====================
//
class HitungEmisiPage extends StatelessWidget {
  const HitungEmisiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body: Center(
        child: Text("🧮 Halaman Hitung Emisi", style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class SimulasiPage extends StatelessWidget {
  const SimulasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body: Center(
        child: Text("🗺️ Halaman Simulasi Perjalanan",
            style: TextStyle(fontSize: 18)),
      ),
    );
  }
}

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFE8F5E9),
      body: Center(
        child: Text("👤 Halaman Profil Pengguna",
            style: TextStyle(fontSize: 18)),
      ),
    );
  }
}