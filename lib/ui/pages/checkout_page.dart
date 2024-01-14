import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Car {
  final String name;
  final String color;
  final String capacity;
  final String status;
  final String imageUrl;

  Car({
    required this.name,
    required this.color,
    required this.capacity,
    required this.status,
    required this.imageUrl,
  });
}

class CarService {
  Future<Car> getCarByName(String carName) async {
    return Car(
      name: carName,
      color: 'Red',
      capacity: '5',
      status: 'Available',
      imageUrl: 'assets/images/avanza.png',
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final CarService carService = CarService();
  Car? selectedCar;

  @override
  void initState() {
    super.initState();
    getCarDetails();
  }

  void getCarDetails() async {
    Car car = await carService.getCarByName('Avanza');
    setState(() {
      selectedCar = car;
    });
  }

  Future<void> insertData(Map<String, dynamic> data) async {
    try {
      await firebaseFirestore.collection('history').add(data);
      pay();
    } catch (e) {
      print(e);
    }
  }

  void cancel() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Batal'),
        content: Text('Apakah Anda yakin ingin membatalkan pemesanan?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Text('Ya'),
          ),
        ],
      ),
    );
  }

  void showConfirmationDialog(Map<String, dynamic> passedData) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Bayar',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Klik "Konfirmasi untuk membayar.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Batalkan',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      insertData(passedData);
                      pay();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Konfirmasi',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pay() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Bayar'),
            const Text(
              'Terima kasih telah memesan!',
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/history');
              },
              child: Column(
                children: [
                  Text('menuju histori'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
      ),
      body: selectedCar == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('    Bali',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Container(
                    height: 200,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            selectedCar!.imageUrl,
                            height: 80,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            selectedCar!.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2B34),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildInfoColumn('Color', carData['color']),
                            buildInfoColumn(
                                'Kapasitas', carData['capacity'].toString()),
                            buildInfoColumn('Status', 'Available'),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            buildInfoColumn('Peminjaman',
                                'Selasa 12-16 Jan | 23:59\n5 Hari'),
                            buildInfoColumn('Bank BCA', 'Rp. 1.000.000'),
                          ],
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: cancel,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Batal'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => showConfirmationDialog(carData),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                            child: Text('Bayar'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildInfoColumn(String title, String value) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
