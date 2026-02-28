# Mini-Project-1-PAB
Nurhidayah | 2409116002 A'24

## 🎨 1. Halaman Pemesanan Desain
Pada halaman utama, aplikasi menampilkan form pemesanan jasa desain grafis. Pengguna dapat mengisi beberapa data yang dibutuhkan sebelum melakukan pemesanan.
Fitur yang tersedia pada halaman ini meliputi:
* Input **Nama Pemesan**
* Pilihan **Jenis Desain** (Logo, Poster, Feed Instagram)
* Tampilan otomatis **Harga sesuai jenis desain**
* Input **Deadline**
* Input **Catatan Tambahan**
* Informasi **Contact Person Desainer**
* Tombol **Tambah ke Keranjang**
* Icon keranjang dengan **badge jumlah pesanan**
Harga akan otomatis berubah ketika jenis desain dipilih. Setelah semua data diisi dan tombol “Tambah ke Keranjang” ditekan, pesanan akan masuk ke halaman keranjang.
Tampilan dirancang sederhana dan informatif agar pengguna mudah melakukan pemesanan jasa desain.

---

## 🧺 2. Keranjang Kosong (Empty Cart State)

Ketika pengguna belum menambahkan pesanan, halaman keranjang akan menampilkan kondisi kosong.

Pada halaman ini ditampilkan:

* Ikon keranjang
* Pesan: **“Belum ada pesanan”**
* Tombol untuk kembali ke halaman pemesanan

Hal ini memberikan informasi yang jelas kepada pengguna bahwa belum ada data yang ditambahkan.

---

## 🛒 3. Keranjang Pesanan

Setelah pengguna menambahkan pesanan, halaman keranjang akan menampilkan daftar pesanan yang telah dibuat.

Setiap item pesanan menampilkan:

* Jenis desain
* Nama pemesan
* Deadline
* Catatan tambahan
* Harga
* Tombol hapus (ikon tempat sampah)

Di bagian bawah halaman ditampilkan:

* **Total harga keseluruhan**
* Tombol **Checkout**

Pengguna dapat menghapus pesanan secara individual menggunakan ikon sampah.

---

## 💳 4. Checkout Modal

Ketika tombol **Checkout** ditekan, akan muncul dialog konfirmasi.

Dialog ini berisi:

* Konfirmasi penyelesaian pesanan
* Total harga pesanan
* Dua pilihan tombol:

  * **Cancel** → membatalkan checkout
  * **Confirm** → menyelesaikan pesanan

Fitur ini bertujuan untuk memastikan pengguna benar-benar ingin menyelesaikan transaksi sebelum data dihapus.

---

## 🎉 5. Konfirmasi Pesanan

Setelah tombol **Confirm** ditekan:

* Pesanan akan dihapus dari keranjang
* Muncul notifikasi: **“Checkout berhasil!”**
* Pengguna kembali ke halaman utama
* Badge keranjang kembali menjadi kosong

Hal ini menandakan proses transaksi telah selesai.

---

## 🔁 Flow Penggunaan (Singkat)

1. User isi form pemesanan
2. Klik **Tambah ke Keranjang**
3. Masuk ke halaman **Keranjang**
4. Hapus pesanan jika perlu
5. Klik **Checkout**
6. Konfirmasi → **Checkout berhasil**
7. Keranjang otomatis kosong

---

# 🛠 Widget yang Digunakan

Aplikasi ini menggunakan beberapa widget utama Flutter, antara lain:

* `MaterialApp`
* `Scaffold`
* `AppBar`
* `TextField`
* `DropdownButtonFormField`
* `ElevatedButton`
* `ListView.builder`
* `Card`
* `AlertDialog`
* `SnackBar`
* `Consumer` (Provider)
* `ChangeNotifier`

---

# 🗂 Arsitektur dan State Management

Aplikasi menggunakan **Provider (ChangeNotifier)** untuk mengelola state keranjang pesanan.

Class `BookingModel` berfungsi untuk:

* Menambahkan pesanan (Create)
* Menampilkan pesanan (Read)
* Menghapus pesanan (Delete)
* Mengosongkan keranjang saat checkout

Setiap perubahan data akan memanggil `notifyListeners()` sehingga tampilan akan otomatis diperbarui.
Biar tinggal push dan beres 😌💜
