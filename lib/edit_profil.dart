import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilPage extends StatefulWidget {
  final String nama;
  final String email;
  final String noHp;
  final String? imagePath;
  final String? password;

  const EditProfilPage({
    super.key,
    required this.nama,
    required this.email,
    required this.noHp,
    this.imagePath,
    this.password,
  });

  @override
  State<EditProfilPage> createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController noHpController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.nama);
    emailController = TextEditingController(text: widget.email);
    noHpController = TextEditingController(text: widget.noHp);
    passwordController = TextEditingController(text: widget.password ?? '');
    confirmPasswordController = TextEditingController(text: widget.password ?? '');
    imagePath = widget.imagePath;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
      });
    }
  }

  void _saveChanges() {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password dan konfirmasi tidak sama")),
      );
      return;
    }

    Navigator.pop(context, {
      'nama': namaController.text,
      'email': emailController.text,
      'noHp': noHpController.text,
      'imagePath': imagePath,
      'password': passwordController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: imagePath != null
                    ? Image.file(File(imagePath!), fit: BoxFit.cover).image
                    : const AssetImage('assets/images/default_avatar.png'),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: _pickImage,
              child: const Text(
                "Ganti Foto Profil",
                style: TextStyle(color: Colors.blueAccent),
              ),
            ),
            const SizedBox(height: 25),

            _inputField("Nama", namaController),
            const SizedBox(height: 15),
            _inputField("Email", emailController),
            const SizedBox(height: 15),
            _inputField("Nomor HP", noHpController),
            const SizedBox(height: 15),

            // password
            _passwordField("Password Baru", passwordController, _isPasswordVisible, () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            }),
            const SizedBox(height: 15),

            // confirm password
            _passwordField("Konfirmasi Password", confirmPasswordController,
                _isConfirmPasswordVisible, () {
              setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              });
            }),

            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _saveChanges,
              child: const Text(
                "Simpan Perubahan",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _passwordField(String label, TextEditingController controller,
      bool isVisible, VoidCallback toggleVisibility) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
