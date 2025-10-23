import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I-TransEC Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const LoginPage(),
    );
  }
}

// ============================
// LOGIN PAGE
// ============================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() {
    if (emailController.text.trim() == "gisella" &&
        passwordController.text.trim() == "130306") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Username atau Password salah!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withValues(0.8),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Masuk Akun",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                  ),
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================
// DASHBOARD PAGE
// ============================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 20,
                    child: Icon(Icons.eco, color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "I-TransEC",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text("Beranda"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.article),
              title: const Text("Berita"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text("Penerima Manfaat"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const KelolaPenerimaPage(),
                  ),
                );
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text(
                "Keluar",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Beranda",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Card(
                color: Colors.green[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green.shade200),
                ),
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.article, color: Colors.green, size: 40),
                        SizedBox(height: 10),
                        Text(
                          "Edit Berita",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Card(
                color: Colors.orange[50],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.orange.shade200),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const KelolaPenerimaPage(),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.group, color: Colors.orange, size: 40),
                        SizedBox(height: 10),
                        Text(
                          "Penerima Manfaat",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================
// KELOLA PENERIMA MANFAAT PAGE (SUDAH BISA TAMBAH DATA)
// ============================
class KelolaPenerimaPage extends StatefulWidget {
  const KelolaPenerimaPage({super.key});

  @override
  State<KelolaPenerimaPage> createState() => _KelolaPenerimaPageState();
}

class _KelolaPenerimaPageState extends State<KelolaPenerimaPage> {
  final List<Map<String, dynamic>> data = [
    {
      "no": 1,
      "judul": "Bagi-bagi sembako",
      "perusahaan": "BP BATAM",
      "email": "email1@gmail.com",
      "rekening": "86812931",
      "target": "Rp100.000",
      "mulai": "03-07-2025",
      "selesai": "31-07-2025",
      "terkumpul": "Rp80.000",
    },
    {
      "no": 2,
      "judul": "Gatau",
      "perusahaan": "ntah",
      "email": "dasdhu@gmail.com",
      "rekening": "2038900429",
      "target": "Rp100.000",
      "mulai": "03-07-2025",
      "selesai": "31-07-2025",
      "terkumpul": "Rp90.000",
    },
  ];

  // fungsi tambah data baru
  void _tambahDataBaru(Map<String, dynamic> newData) {
    setState(() {
      data.add({
        "no": data.length + 1,
        ...newData,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Penerima Manfaat'),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // buka halaman tambah penerima
          final newData = await Navigator.push<Map<String, dynamic>>(
            context,
            MaterialPageRoute(builder: (context) => const TambahPenerimaPage()),
          );
          // kalau form disimpan, tambahkan ke tabel
          if (newData != null) {
            _tambahDataBaru(newData);
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Tambah Penerima'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor:
                WidgetStateProperty.all(Colors.green[700]),
            headingTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            border: TableBorder.all(color: Colors.grey.shade300),
            columns: const [
              DataColumn(label: Text('No.')),
              DataColumn(label: Text('Judul Program')),
              DataColumn(label: Text('Nama Perusahaan')),
              DataColumn(label: Text('Email')),
              DataColumn(label: Text('Rekening')),
              DataColumn(label: Text('Target Donasi')),
              DataColumn(label: Text('Tanggal Mulai')),
              DataColumn(label: Text('Tanggal Selesai')),
              DataColumn(label: Text('Total Terkumpul')),
            ],
            rows: data
                .map(
                  (row) => DataRow(
                    cells: [
                      DataCell(Text(row["no"].toString())),
                      DataCell(Text(row["judul"])),
                      DataCell(Text(row["perusahaan"])),
                      DataCell(Text(row["email"])),
                      DataCell(Text(row["rekening"])),
                      DataCell(Text(row["target"])),
                      DataCell(Text(row["mulai"])),
                      DataCell(Text(row["selesai"])),
                      DataCell(Text(row["terkumpul"])),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

// ============================
// TAMBAH PENERIMA PAGE
// ============================
class TambahPenerimaPage extends StatefulWidget {
  const TambahPenerimaPage({super.key});

  @override
  State<TambahPenerimaPage> createState() => _TambahPenerimaPageState();
}

class _TambahPenerimaPageState extends State<TambahPenerimaPage> {
  final _formKey = GlobalKey<FormState>();
  final judulController = TextEditingController();
  final perusahaanController = TextEditingController();
  final emailController = TextEditingController();
  final rekeningController = TextEditingController();
  final targetController = TextEditingController();
  final mulaiController = TextEditingController();
  final selesaiController = TextEditingController();
  final terkumpulController = TextEditingController();

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        "judul": judulController.text,
        "perusahaan": perusahaanController.text,
        "email": emailController.text,
        "rekening": rekeningController.text,
        "target": targetController.text,
        "mulai": mulaiController.text,
        "selesai": selesaiController.text,
        "terkumpul": terkumpulController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Penerima Manfaat'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: judulController,
                decoration: const InputDecoration(labelText: "Judul Program"),
                validator: (value) =>
                    value!.isEmpty ? "Harus diisi" : null,
              ),
              TextFormField(
                controller: perusahaanController,
                decoration:
                    const InputDecoration(labelText: "Nama Perusahaan"),
                validator: (value) =>
                    value!.isEmpty ? "Harus diisi" : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    value!.isEmpty ? "Harus diisi" : null,
              ),
              TextFormField(
                controller: rekeningController,
                decoration: const InputDecoration(labelText: "Rekening"),
                validator: (value) =>
                    value!.isEmpty ? "Harus diisi" : null,
              ),
              TextFormField(
                controller: targetController,
                decoration: const InputDecoration(labelText: "Target Donasi"),
                validator: (value) =>
                    value!.isEmpty ? "Harus diisi" : null,
              ),
              TextFormField(
                controller: mulaiController,
                decoration: const InputDecoration(labelText: "Tanggal Mulai"),
                validator: (value) =>
                    value!.isEmpty ? "Harus diisi" : null,
              ),
              TextFormField(
                controller: selesaiController,
                decoration:
                    const InputDecoration(labelText: "Tanggal Selesai"),
                validator: (value) =>
                    value!.isEmpty ? "Harus diisi" : null,
              ),
              TextFormField(
                controller: terkumpulController,
                decoration:
                    const InputDecoration(labelText: "Total Terkumpul"),
                validator: (value) =>
                    value!.isEmpty ? "Harus diisi" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _simpanData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                ),
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
