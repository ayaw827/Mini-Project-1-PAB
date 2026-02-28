# Mini-Project-1-PAB
Nurhidayah | 2409116002 A'24

## 1. Halaman Pemesanan Desain

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/41e0ed00-bf57-4eb2-a40c-653e324d43a8" />

Pada halaman utama aplikasi, saya menampilkan form pemesanan jasa desain grafis yang dapat digunakan oleh pengguna untuk melakukan pemesanan. Di halaman ini, pengguna diminta untuk mengisi beberapa data seperti nama pemesan, memilih jenis desain (Logo, Poster, atau Feed Instagram), menentukan deadline, serta menambahkan catatan tambahan jika diperlukan. Harga akan otomatis berubah sesuai dengan jenis desain yang dipilih melalui dropdown. Saya juga menampilkan informasi contact person desainer agar pengguna mengetahui pihak yang dapat dihubungi. Selain itu, terdapat tombol “Tambah ke Keranjang” untuk menyimpan pesanan serta ikon keranjang dengan badge yang menunjukkan jumlah pesanan yang telah ditambahkan. Tampilan halaman ini saya rancang sederhana dan informatif agar memudahkan pengguna dalam melakukan pemesanan.

## 2. Keranjang Kosong (Empty Cart State)

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/fa5577e5-3e01-4edf-869c-4e10ecfcd140" />

Pada halaman keranjang, jika pengguna belum menambahkan pesanan, maka akan ditampilkan kondisi keranjang kosong. Saya menampilkan ikon keranjang disertai pesan “Belum ada pesanan” sebagai informasi bahwa belum ada data yang tersimpan. Selain itu, tersedia tombol untuk kembali ke halaman pemesanan agar pengguna dapat langsung melakukan pemesanan. Tampilan ini bertujuan untuk memberikan feedback yang jelas kepada pengguna mengenai status keranjang mereka.

## 3. Keranjang Pesanan

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/210b8d77-54f8-4971-a641-d502fe7e91fb" />

Setelah pengguna menambahkan pesanan, halaman keranjang akan menampilkan daftar pesanan yang telah dibuat. Setiap item pesanan ditampilkan dalam bentuk card yang berisi informasi jenis desain, nama pemesan, deadline, catatan tambahan, serta harga. Saya juga menyediakan tombol hapus berupa ikon tempat sampah agar pengguna dapat menghapus pesanan secara individual. Di bagian bawah halaman, saya menampilkan total harga keseluruhan dari semua pesanan yang ada, serta tombol “Checkout” untuk melanjutkan proses penyelesaian transaksi. Dengan tampilan ini, pengguna dapat melihat dan mengelola seluruh pesanan yang telah dibuat.

## 4. Checkout Modal

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c1dbf1ba-5c8e-4c8e-bee8-b76d6621a005" />

Ketika tombol “Checkout” ditekan, saya menampilkan dialog konfirmasi menggunakan AlertDialog. Dialog ini berisi konfirmasi penyelesaian pesanan serta total harga yang harus dibayarkan. Pengguna diberikan dua pilihan, yaitu tombol “Cancel” untuk membatalkan proses checkout dan tombol “Confirm” untuk menyelesaikan pesanan. Fitur ini saya tambahkan sebagai langkah validasi agar pengguna benar-benar yakin sebelum menyelesaikan transaksi dan menghapus seluruh data pesanan dari keranjang.

## 5. Konfirmasi Pesanan

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f364950e-5c73-4870-9206-1e099d99571f" />

Setelah pengguna menekan tombol “Confirm”, seluruh pesanan akan dihapus dari keranjang melalui fungsi clear pada provider. Kemudian muncul notifikasi berupa SnackBar dengan pesan “Checkout berhasil!” sebagai tanda bahwa proses transaksi telah selesai. Pengguna akan kembali ke halaman utama, dan badge pada ikon keranjang akan kembali kosong. Hal ini menandakan bahwa proses pemesanan telah berhasil diselesaikan dan sistem kembali ke kondisi awal.

## Flow Penggunaan

1. User isi form pemesanan
2. Klik **Tambah ke Keranjang**
3. Masuk ke halaman **Keranjang**
4. Hapus pesanan jika perlu
5. Klik **Checkout**
6. Konfirmasi → **Checkout berhasil**
7. Keranjang otomatis kosong

# 🛠 Widget yang Digunakan

Aplikasi ini menggunakan beberapa widget utama Flutter, antara lain:

## 1. main.dart

```
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/booking_model.dart';
import 'pages/paket_list_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => BookingModel(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistem Pemesanan Desain',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const PaketListPage(),
    );
  }
}
```

Pada file `main.dart`, saya mengatur entry point dari aplikasi. Di bagian ini saya menggunakan `ChangeNotifierProvider` untuk membungkus `MyApp`, sehingga state dari `BookingModel` dapat diakses oleh seluruh halaman dalam aplikasi. Saya juga menggunakan `MaterialApp` untuk mengatur tema aplikasi, judul aplikasi, serta menentukan halaman awal yaitu `PaketListPage`.
Dengan penggunaan Provider pada bagian ini, saya dapat mengelola state keranjang secara terpusat dan memastikan tampilan akan otomatis diperbarui ketika data berubah.

## 2. booking_model.dart

```
import 'package:flutter/material.dart';
import 'booking_item.dart';

class BookingModel extends ChangeNotifier {
  final List<BookingItem> _items = [];

  List<BookingItem> get items => _items;

  void tambahBooking(BookingItem item) {
    _items.add(item);
    notifyListeners();
  }

  void hapusBooking(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  int get totalHarga {
    return _items.fold(0, (total, item) => total + item.harga);
  }

  void clearBooking() {
    _items.clear();
    notifyListeners();
  }

  void removeItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }
}
```

Pada file ini saya membuat class `BookingModel` yang meng-extend `ChangeNotifier`. Class ini berfungsi untuk mengelola seluruh data pesanan yang dimasukkan ke dalam keranjang. Di dalamnya terdapat list `_items` yang menyimpan data pesanan.
Beberapa method yang saya buat antara lain:
* `tambahBooking()` untuk menambahkan pesanan ke dalam list
* `hapusBooking()` dan `removeItem()` untuk menghapus pesanan
* `totalHarga` untuk menghitung total seluruh harga pesanan
* `clearBooking()` untuk mengosongkan keranjang saat checkout

Setiap ada perubahan data, saya memanggil `notifyListeners()` agar tampilan otomatis diperbarui tanpa perlu reload manual.

## 3️. booking_item.dart

```
class BookingItem {
  final String namaPemesan;
  final String jenisDesain;
  final int harga;
  final String deadline;
  final String note;

  BookingItem({
    required this.namaPemesan,
    required this.jenisDesain,
    required this.harga,
    required this.deadline,
    required this.note,
  });
}
```

Pada file ini saya membuat class `BookingItem` yang berfungsi sebagai model data untuk satu pesanan.
Class ini menyimpan beberapa informasi penting seperti:
* Nama pemesan
* Jenis desain
* Harga
* Deadline
* Catatan tambahan

Class ini hanya berfungsi sebagai struktur data dan tidak memiliki logic tambahan. Tujuannya agar data pesanan lebih terstruktur dan mudah dikelola.

## 4️. paket_desain.dart

```
class PaketDesain {
  final String id;
  final String namaPaket;
  final int harga;
  final String image;
  final String deskripsi;

  PaketDesain({
    required this.id,
    required this.namaPaket,
    required this.harga,
    required this.image,
    required this.deskripsi,
  });
}
```

Pada file `paket_desain.dart`, saya membuat class `PaketDesain` yang dapat digunakan untuk merepresentasikan paket desain secara lebih terstruktur, seperti nama paket, harga, gambar, dan deskripsi.
Walaupun pada implementasi saat ini jenis desain masih dipilih melalui dropdown sederhana, class ini saya siapkan agar aplikasi dapat dikembangkan lebih lanjut menjadi sistem katalog desain yang lebih kompleks.

## 5. cart_page.dart

```
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
```

Pada halaman `CartPage`, saya menampilkan seluruh pesanan yang telah dimasukkan ke dalam keranjang. Jika tidak ada pesanan, maka akan ditampilkan tampilan kosong dengan pesan “Belum ada pesanan”. Jika terdapat pesanan, saya menggunakan `ListView.builder` untuk menampilkan daftar item secara dinamis sesuai jumlah data dalam provider.
Setiap item ditampilkan dalam bentuk `Card` dan `ListTile` yang berisi:
* Jenis desain
* Nama pemesan
* Deadline
* Catatan tambahan
* Harga
* Tombol hapus

Di bagian bawah halaman, saya menampilkan total harga serta tombol Checkout. Saat tombol Checkout ditekan, saya menampilkan `AlertDialog` sebagai konfirmasi. Jika pengguna memilih “Ya”, maka fungsi `clearBooking()` akan dijalankan, keranjang akan dikosongkan, dan muncul `SnackBar` dengan pesan “Checkout berhasil”.

## 4️. paket_list_page.dart

```
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
```

Halaman `PaketListPage` merupakan halaman utama aplikasi yang saya buat untuk form pemesanan desain.

Pada halaman ini, pengguna dapat:
* Mengisi nama pemesan
* Memilih jenis desain melalui `DropdownButtonFormField`
* Melihat harga yang berubah otomatis sesuai jenis desain
* Mengisi deadline
* Menambahkan catatan tambahan
* Menambahkan pesanan ke keranjang

Saya menggunakan `Consumer<BookingModel>` pada ikon keranjang agar badge jumlah pesanan dapat berubah secara otomatis ketika data dalam provider berubah. Saya juga menambahkan validasi sederhana untuk memastikan bahwa nama dan deadline tidak kosong sebelum pesanan ditambahkan. Jika kosong, maka akan muncul `SnackBar` sebagai peringatan.

## 📌 Struktur Folder Project

<img width="375" height="294" alt="image" src="https://github.com/user-attachments/assets/e76dd416-e6e3-4362-94c9-5e3e6812b1b8" />

