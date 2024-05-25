import 'package:flutter/material.dart';

class RecommendedCategoryProvider extends ChangeNotifier {
  final List<String> _recommendedCategories = [];
  late bool _trigger = false;

  bool get trigger => _trigger;

  List<String> get recommendedCategories => _recommendedCategories;

  void addCategory(String category) {
    _recommendedCategories.add(category);
    notifyListeners();
  }

  void changeTrigger(bool trigger) {
    _trigger = trigger;
    notifyListeners();
  }

  void removeCategory(String category) {
    _recommendedCategories.remove(category);
    notifyListeners();
  }
}
