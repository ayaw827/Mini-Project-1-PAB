import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/booking_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookingModel = Provider.of<BookingModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Keranjang Pesanan")),
      body: bookingModel.items.isEmpty
          ? const Center(
              child: Text("Belum ada pesanan", style: TextStyle(fontSize: 16)),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: bookingModel.items.length,
                    itemBuilder: (context, index) {
                      final item = bookingModel.items[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text(
                            item.jenisDesain,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              Text("Nama: ${item.namaPemesan}"),
                              Text("Deadline: ${item.deadline}"),
                              Text(
                                "Note: ${item.note.isEmpty ? '-' : item.note}",
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rp ${item.harga}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  bookingModel.removeItem(index);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Pesanan dihapus"),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // TOTAL & CHECKOUT
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Total: Rp ${bookingModel.totalHarga}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Konfirmasi Checkout"),
                                content: const Text(
                                  "Yakin ingin menyelesaikan pesanan?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Batal"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      bookingModel.clearBooking();
                                      Navigator.pop(context); // tutup dialog
                                      Navigator.pop(
                                        context,
                                      ); // balik ke halaman utama

                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text("Checkout berhasil!"),
                                        ),
                                      );
                                    },
                                    child: const Text("Ya"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text("Checkout"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
