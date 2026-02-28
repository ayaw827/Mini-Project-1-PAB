import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/booking_model.dart';
import '../model/booking_item.dart';
import 'cart_page.dart';

class PaketListPage extends StatefulWidget {
  const PaketListPage({super.key});

  @override
  State<PaketListPage> createState() => _PaketListPageState();
}

class _PaketListPageState extends State<PaketListPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String jenisDesain = "Logo";
  int harga = 50000;

  @override
  void dispose() {
    namaController.dispose();
    deadlineController.dispose();
    noteController.dispose();
    super.dispose();
  }

  void updateHarga(String jenis) {
    setState(() {
      jenisDesain = jenis;

      switch (jenis) {
        case "Logo":
          harga = 50000;
          break;
        case "Poster":
          harga = 75000;
          break;
        case "Feed Instagram":
          harga = 30000;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Pemesanan Desain"),
        actions: [
          Consumer<BookingModel>(
            builder: (context, bookingModel, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CartPage()),
                      );
                    },
                  ),
                  if (bookingModel.items.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          bookingModel.items.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 NAMA
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Pemesan",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 JENIS DESAIN
              DropdownButtonFormField<String>(
                value: jenisDesain,
                items: const [
                  DropdownMenuItem(value: "Logo", child: Text("Logo")),
                  DropdownMenuItem(value: "Poster", child: Text("Poster")),
                  DropdownMenuItem(
                    value: "Feed Instagram",
                    child: Text("Feed Instagram"),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    updateHarga(value);
                  }
                },
                decoration: const InputDecoration(
                  labelText: "Jenis Desain",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 HARGA
              Text(
                "Harga: Rp $harga",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 DEADLINE
              TextField(
                controller: deadlineController,
                decoration: const InputDecoration(
                  labelText: "Deadline (contoh: 25 Juni 2026)",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 NOTE
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Catatan Tambahan",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 CONTACT PERSON (DI BAWAH)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Person Desainer",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text("Nama: Aya Design Studio"),
                    Text("WhatsApp: 0812-3456-7890"),
                    Text("Instagram: @ayadesign"),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 🔹 BUTTON FULL WIDTH
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (namaController.text.isEmpty ||
                        deadlineController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Nama dan Deadline wajib diisi"),
                        ),
                      );
                      return;
                    }

                    final booking = BookingItem(
                      namaPemesan: namaController.text,
                      jenisDesain: jenisDesain,
                      harga: harga,
                      deadline: deadlineController.text,
                      note: noteController.text,
                    );

                    Provider.of<BookingModel>(
                      context,
                      listen: false,
                    ).tambahBooking(booking);

                    namaController.clear();
                    deadlineController.clear();
                    noteController.clear();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Pesanan berhasil ditambahkan"),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text("Tambah ke Keranjang"),
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
