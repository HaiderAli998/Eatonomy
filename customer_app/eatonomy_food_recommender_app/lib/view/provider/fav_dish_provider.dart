import 'dart:convert';

import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/dish_data_model.dart';

class DishProvider extends ChangeNotifier {
  final List<DishModel> _dishes = [];

  List<DishModel> get dishes => _dishes;

  DishProvider() {
    _loadDishes();
  }

  void addDish(DishModel model) {
    _dishes.add(model);
    Utils.toastMessage('ADD Data');
    _saveDishes();
    notifyListeners();
  }

  void removeDish(int id) {
    _dishes.removeWhere((dish) => dish.dishID == id);
    Utils.toastMessage('Dish removed');
    _saveDishes();
    notifyListeners();
  }

  bool isLiked(int id) {
    return _dishes.any((dish) => dish.dishID == id && dish.isLiked);
  }

  Future<void> _loadDishes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? dishesString = prefs.getString('dishes');
    if (dishesString != null) {
      final List<dynamic> dishesJson = json.decode(dishesString);
      _dishes.clear();
      _dishes.addAll(
          dishesJson.map((json) => DishModel.fromJson(json, () {})).toList());
      notifyListeners();
    }
  }

  Future<void> _saveDishes() async {
    final prefs = await SharedPreferences.getInstance();
    final String dishesString =
        json.encode(_dishes.map((dish) => dish.toJson()).toList());
    await prefs.setString('dishes', dishesString);
  }
}
