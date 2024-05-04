import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FavRestaurantProvider with ChangeNotifier {
  final List<int> _selectedItems = [];

  void setItem(int index) {
    _selectedItems.add(index);
    notifyListeners();
  }

  void removeItem(int index) {
    _selectedItems.removeAt(index);
    notifyListeners();
  }

  List get selectedItems => _selectedItems;
}
