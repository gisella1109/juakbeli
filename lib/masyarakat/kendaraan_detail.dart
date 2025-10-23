import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

/// ======= MODEL SEDERHANA =======
/// Kita pakai payload sederhana untuk tiap kendaraan
class VehicleType {
  final String id;
  final String name;
  final String assetEmoji; // gunakan emoji untuk ilustrasi cepat
  final List<String> capacities; // label kapasitas (CC atau kW)
  final List<String> fuels; // jenis bahan bakar yang tersedia

  const VehicleType({
    required this.id,
    required this.name,
    required this.assetEmoji,
    required this.capacities,
    required this.fuels,
  });
}

/// ======= DATA APLIKASI =======
/// Capacities & fuels disesuaikan per kendaraan (meniru wireframe)
final List<VehicleType> vehicles = [
  VehicleType(
    id: 'mobil',
    name: 'Mobil',
    assetEmoji: '🚗',
    capacities: ['1000-1999 CC', '2000-2999 CC', '3000-3900 CC'],
    fuels: ['Pertamax', 'Pertalite', 'Solar'],
  ),
  VehicleType(
    id: 'bus',
    name: 'Bus',
    assetEmoji: '🚌',
    capacities: ['2000-3000 CC', '4000-7000 CC', '8000-12000 CC'],
    fuels: ['Solar'], // bus umumnya diesel/solar
  ),
  VehicleType(
    id: 'motor',
    name: 'Motor',
    assetEmoji: '🏍️',
    capacities: ['100-400 CC', '500-1000 CC', '>1000 CC'],
    fuels: ['Pertalite', 'Pertamax'],
  ),
  VehicleType(
    id: 'mobil_listrik',
    name: 'Mobil Listrik',
    assetEmoji: '🔌',
    capacities: ['30-100 kW', '100-200 kW', '200-377 kW'],
    fuels: ['Listrik'], // fuel = listrik
  ),
];

/// ======= ESTIMASI FAKTOR EMISI (Sederhana untuk demo) =======
/// Nilai-nilai di bawah hanyalah contoh numerik untuk demo UI.
/// Angka merupakan estimasi emisi per km (kg CO2/km) yang disesuaikan
/// berdasarkan jenis bahan bakar dan kapasitas. Nanti dikonversi ke gram.
double estimateKgPerKm({
  required String vehicleId,
  required String capacityLabel,
  required String fuel,
}) {
  // baseline per vehicle type
  double base = 0.2; // default kg/km

  // adjust by vehicle
  if (vehicleId == 'mobil') base = 0.18;
  if (vehicleId == 'bus') base = 0.5;
  if (vehicleId == 'motor') base = 0.08;
  if (vehicleId == 'mobil_listrik') base = 0.05; // tergantung sumber listrik

  // capacity modifier (bigger engine -> sedikit lebih boros)
  double capModifier = 1.0;
  if (capacityLabel.contains('1000') || capacityLabel.contains('100-400') || capacityLabel.contains('30-100')) {
    capModifier = 0.9;
  } else if (capacityLabel.contains('2000') || capacityLabel.contains('500-1000') || capacityLabel.contains('100-200')) {
    capModifier = 1.0;
  } else if (capacityLabel.contains('3000') || capacityLabel.contains('4000') || capacityLabel.contains('>1000') || capacityLabel.contains('200-377')) {
    capModifier = 1.25;
  } else if (capacityLabel.contains('8000') || capacityLabel.contains('1000-1999')) {
    capModifier = 1.3;
  }

  // fuel modifier (estimasi)
  double fuelModifier = 1.0;
  switch (fuel.toLowerCase()) {
    case 'pertamax':
      fuelModifier = 1.0;
      break;
    case 'pertalite':
      fuelModifier = 1.05;
      break;
    case 'solar':
      fuelModifier = 1.15;
      break;
    case 'listrik':
      // listrik: tergantung sumber, kita asumsikan rendah
      fuelModifier = 0.25;
      break;
    default:
      fuelModifier = 1.0;
  }

  // final kg/km
  double kgPerKm = base * capModifier * fuelModifier;

  // safety clamp
  kgPerKm = kgPerKm.clamp(0.01, 5.0);

  // add tiny randomness to simulate variasi (deterministic-ish)
  double noise = (math.sin(kgPerKm * 13.37) * 0.005);
  return kgPerKm + noise;
}

/// ======= APLIKASI UTAMA =======
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hitung Emisi Kendaraan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

/// ======= HOME SCREEN: Pilih Kendaraan =======
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hitung Emisi'),
        backgroundColor: Colors.green[700],
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hai Sella\nMenghitung emisi karbon kendaraan\nPilih jenis kendaraan kamu',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.05,
              ),
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final v = vehicles[index];
                return VehicleCard(
                  vehicle: v,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SelectOptionsScreen(vehicle: v),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green[600],
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.calculate, color: Colors.white),
              Icon(Icons.map, color: Colors.white),
              Icon(Icons.person, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

/// ======= WIDGET: Vehicle Card =======
class VehicleCard extends StatelessWidget {
  final VehicleType vehicle;
  final VoidCallback onTap;
  const VehicleCard({super.key, required this.vehicle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // circle icon
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    vehicle.assetEmoji,
                    style: const TextStyle(fontSize: 36),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                vehicle.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ======= SCREEN: Select capacity & fuel =======
class SelectOptionsScreen extends StatefulWidget {
  final VehicleType vehicle;
  const SelectOptionsScreen({super.key, required this.vehicle});

  @override
  State<SelectOptionsScreen> createState() => _SelectOptionsScreenState();
}

class _SelectOptionsScreenState extends State<SelectOptionsScreen> {
  String? selectedCapacity;
  String? selectedFuel;
  final TextEditingController _kmPerYearController = TextEditingController(text: '15000'); // default km per year

  @override
  void dispose() {
    _kmPerYearController.dispose();
    super.dispose();
  }

  void _calculateAndShow() {
    if (selectedCapacity == null || selectedFuel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih kapasitas mesin dan jenis bahan bakar dulu.')),
      );
      return;
    }

    double kgPerKm = estimateKgPerKm(
      vehicleId: widget.vehicle.id,
      capacityLabel: selectedCapacity!,
      fuel: selectedFuel!,
    );
    double gPerKm = kgPerKm * 1000;
    int kmPerYear = int.tryParse(_kmPerYearController.text.replaceAll(',', '')) ?? 15000;
    double kgPerYear = kgPerKm * kmPerYear;

    // Tampilkan halaman hasil
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(
          vehicle: widget.vehicle,
          capacity: selectedCapacity!,
          fuel: selectedFuel!,
          gPerKm: gPerKm,
          kgPerYear: kgPerYear,
          kmPerYear: kmPerYear,
        ),
      ),
    );
  }

  Widget _buildChips(List<String> items, String? selected, void Function(String) onSelect) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((it) {
        final bool isSel = it == selected;
        return ChoiceChip(
          label: Text(it),
          selected: isSel,
          onSelected: (_) {
            onSelect(it);
          },
          selectedColor: Colors.green[200],
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final v = widget.vehicle;
    return Scaffold(
      appBar: AppBar(
        title: Text(v.name),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(child: Text(v.assetEmoji, style: const TextStyle(fontSize: 44))),
                  ),
                  const SizedBox(height: 12),
                  Text(v.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Kapasitas mesin', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: _buildChips(v.capacities, selectedCapacity, (val) {
                  setState(() => selectedCapacity = val);
                }),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Jenis bahan bakar', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: _buildChips(v.fuels, selectedFuel, (val) {
                  setState(() => selectedFuel = val);
                }),
              ),
            ),
            const SizedBox(height: 16),
            const Text('Jarak tempuh per tahun (km)', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _kmPerYearController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '15000',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                  onPressed: _calculateAndShow,
                  child: const Text('Hitung Emisi'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Informasi kecil
            const Text(
              'Catatan: hasil merupakan estimasi. Untuk akurasi, gunakan data konsumsi bahan bakar nyata atau faktor emisi resmi.',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// ======= SCREEN: Result =======
class ResultScreen extends StatelessWidget {
  final VehicleType vehicle;
  final String capacity;
  final String fuel;
  final double gPerKm;
  final double kgPerYear;
  final int kmPerYear;

  const ResultScreen({
    super.key,
    required this.vehicle,
    required this.capacity,
    required this.fuel,
    required this.gPerKm,
    required this.kgPerYear,
    required this.kmPerYear,
  });

  @override
  Widget build(BuildContext context) {
    String formattedGPerKm = gPerKm.toStringAsFixed(1);
    String formattedKgYear = kgPerYear.toStringAsFixed(1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Emisi'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(child: Text(vehicle.assetEmoji, style: const TextStyle(fontSize: 48))),
            ),
            const SizedBox(height: 12),
            Text(vehicle.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRow(label: 'Kapasitas', value: capacity),
                    const SizedBox(height: 8),
                    InfoRow(label: 'Bahan Bakar', value: fuel),
                    const SizedBox(height: 8),
                    InfoRow(label: 'Perkiraan emisi', value: '$formattedGPerKm g CO₂/km'),
                    const SizedBox(height: 8),
                    InfoRow(label: 'Jarak per tahun', value: '$kmPerYear km'),
                    const SizedBox(height: 8),
                    InfoRow(label: 'Estimasi per tahun', value: '$formattedKgYear kg CO₂'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Sederhana: tombol kembali / share
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Ubah Pilihan'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[600]),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // contoh tindakan: tampilkan snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Hasil disalin (simulasi).')),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Bagikan'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

/// ======= SMALL WIDGET: InfoRow =======
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
