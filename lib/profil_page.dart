import 'dart:io';
import 'package:flutter/material.dart';
import 'edit_profil.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({super.key});

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  String nama = "Naufal Hakim";
  String email = "naufal@example.com";
  String username = "Featherine";
  String password = "hahayuk";
  String noHp = "081234567890";
  String? imagePath;
  bool _isPasswordVisible = false; // <-- untuk toggle mata password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: imagePath != null
                    ? Image.file(File(imagePath!), fit: BoxFit.cover).image
                    : const AssetImage('assets/images/default_avatar.png'),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              username,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(email, style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 20),

            // Info Card
            Container(
  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.grey.shade200, width: 1),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  ),
  child: Column(
    children: [
      _infoItem(Icons.person, "Nama", nama),
      const Divider(thickness: 0.8, height: 20),
      _infoItem(Icons.email, "Email", email),
      const Divider(thickness: 0.8, height: 20),
      _infoItem(Icons.phone, "Nomor HP", noHp),
      const Divider(thickness: 0.8, height: 20),
      _passwordItem(),
    ],
  ),
),

            // Tombol Edit Profil
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              icon: const Icon(Icons.edit),
              label: const Text(
                "Edit Profil",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                final updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilPage(
                      nama: nama,
                      email: email,
                      noHp: noHp,
                      imagePath: imagePath,
                    ),
                  ),
                );
                if (updatedData != null) {
                  setState(() {
                    nama = updatedData['nama'];
                    email = updatedData['email'];
                    noHp = updatedData['noHp'];
                    imagePath = updatedData['imagePath'];
                  });
                }
              },
            ),
            const SizedBox(height: 30),

            // Menu tambahan
            _menuItem(Icons.history, "Riwayat", () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Menu Riwayat diklik")),
              );
            }),
            _menuItem(Icons.credit_card, "Tebus Emisi", () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Menu Tebus Emisi diklik")),
              );
            }),
            const Divider(height: 40),
            _menuItem(Icons.logout, "Log out", () {
              Navigator.pushReplacementNamed(context, '/login');
            }),
          ],
        ),
      ),
    );
  }

  // Widget info profil biasa
Widget _infoItem(IconData icon, String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Widget khusus password dengan ikon mata
Widget _passwordItem() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.lock, color: Colors.blueAccent),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Password",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _isPasswordVisible ? password : '•' * password.length,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ],
    ),
  );
}


  // Menu navigasi (Riwayat, Tebus Emisi, Logout)
  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      onTap: onTap,
    );
  }
}
