import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BeritaAdminPage extends StatefulWidget {
  const BeritaAdminPage({super.key});

  @override
  State<BeritaAdminPage> createState() => _BeritaAdminPageState();
}

class _BeritaAdminPageState extends State<BeritaAdminPage> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _isiController = TextEditingController();

  File? _imageFile; // Menyimpan foto berita
  final ImagePicker _picker = ImagePicker();

  // 🧩 List berita yang sudah disimpan
  final List<Map<String, dynamic>> _beritaList = [];

  // 🔹 Ambil gambar dari galeri
  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  // 🔹 Simpan berita
  void _simpanBerita() {
    if (_judulController.text.isEmpty || _isiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua kolom sebelum menyimpan!')),
      );
      return;
    }

    setState(() {
      _beritaList.add({
        'judul': _judulController.text,
        'isi': _isiController.text,
        'foto': _imageFile,
      });
      _judulController.clear();
      _isiController.clear();
      _imageFile = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Berita berhasil disimpan!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelola Berita"),
        backgroundColor: const Color(0xFF4CAF50),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFFF2F5FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tambah Berita Baru",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // 🟩 Input Judul Berita
            TextField(
              controller: _judulController,
              decoration: InputDecoration(
                labelText: "Judul Berita",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🟩 Input Isi Berita
            TextField(
              controller: _isiController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Isi Berita",
                alignLabelWithHint: true,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🟩 Tambah Foto
            Center(
              child: Column(
                children: [
                  _imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            _imageFile!,
                            width: 250,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: 250,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text(
                              "Belum ada foto",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _pickImage,
                    icon: const Icon(Icons.photo),
                    label: const Text("Pilih Foto"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 🟩 Tombol Simpan
            Center(
              child: ElevatedButton.icon(
                onPressed: _simpanBerita,
                icon: const Icon(Icons.save_rounded),
                label: const Text("Simpan Berita"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  textStyle:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 📰 Daftar Berita
            const Text(
              "Daftar Berita",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            _beritaList.isEmpty
                ? const Text("Belum ada berita yang disimpan.")
                : Column(
                    children: _beritaList.map((berita) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: berita['foto'] != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    berita['foto'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.image_not_supported, size: 40),
                          title: Text(
                            berita['judul'],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Text(
                            berita['isi'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
