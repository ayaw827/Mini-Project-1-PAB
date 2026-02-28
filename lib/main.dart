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
