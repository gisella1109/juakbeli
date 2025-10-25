import 'package:flutter/material.dart';
import 'donasi_admin.dart'; // ✅ Halaman penerima
import 'berita_admin.dart'; // ✅ Halaman berita admin

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5FA),

      // ✅ SIDEBAR (Drawer)
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Color(0xFF4CAF50),
                    radius: 24,
                    child: Icon(Icons.eco_rounded, color: Colors.white, size: 26),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "I-TransEC Admin",
                    style: TextStyle(
                      color: Color(0xFF4CAF50),
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_rounded, color: Color(0xFF4CAF50)),
              title: const Text("Dashboard"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.article_rounded, color: Colors.black54),
              title: const Text("Berita"),
              onTap: () {
                // ✅ Arahkan ke halaman berita admin
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BeritaAdminPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.volunteer_activism_rounded, color: Colors.black54),
              title: const Text("Penerima"),
              onTap: () {
                // ✅ Arahkan ke halaman penerima
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KelolaPenerimaPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people_alt_rounded, color: Colors.black54),
              title: const Text("Anggota Aktif"),
              onTap: () {},
            ),
            const Spacer(),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              title: const Text(
                "Keluar",
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // ✅ APPBAR
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: const Text(
          "Beranda",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ✅ BODY (3 MENU UTAMA)
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _menuButton(
              icon: Icons.newspaper_rounded,
              text: "Edit Berita",
              onTap: () {
                // ✅ Buka halaman berita admin
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BeritaAdminPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            _menuButton(
              icon: Icons.volunteer_activism_rounded,
              text: "Penerima",
              onTap: () {
                // ✅ Buka halaman penerima
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KelolaPenerimaPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 25),
            _menuButton(
              icon: Icons.people_alt_rounded,
              text: "Anggota Aktif",
              onTap: () {
                // Nanti arahkan ke halaman anggota aktif
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget tombol menu
  Widget _menuButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 38),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
