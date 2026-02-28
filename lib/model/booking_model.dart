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
