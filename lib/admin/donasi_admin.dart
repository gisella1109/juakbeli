import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      "perusahaan": "Ntah",
      "email": "dasdhu@gmail.com",
      "rekening": "2038900429",
      "target": "Rp100.000",
      "mulai": "03-07-2025",
      "selesai": "31-07-2025",
      "terkumpul": "Rp90.000",
    },
    {
      "no": 3,
      "judul": "Bikini Bottom membutuhkan",
      "perusahaan": "PT. Bikini",
      "email": "admin@gmail.com",
      "rekening": "23454",
      "target": "Rp499.999",
      "mulai": "23-06-2025",
      "selesai": "24-06-2025",
      "terkumpul": "Rp400.000",
    },
    {
      "no": 4,
      "judul": "Hijaukan Bumi",
      "perusahaan": "PT. Jaya",
      "email": "itransc@gmail.com",
      "rekening": "123456",
      "target": "Rp1.000.000",
      "mulai": "23-06-2025",
      "selesai": "30-06-2025",
      "terkumpul": "Rp800.000",
    },
  ];

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
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Kelola Penerima Manfaat",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tombol Tambah
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final newData = await Navigator.push<Map<String, dynamic>>(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TambahPenerimaPage(),
                      ),
                    );
                    if (newData != null) {
                      _tambahDataBaru(newData);
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Tambah Penerima',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              // Table Data
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: WidgetStateProperty.all(Colors.green[700]),
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
            ],
          ),
        ),
      ),
    );
  }
}

// =================================
// FORM TAMBAH PENERIMA
// =================================
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
