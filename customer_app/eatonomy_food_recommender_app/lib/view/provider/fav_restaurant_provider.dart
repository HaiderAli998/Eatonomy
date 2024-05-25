import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/Utils.dart';
import '../model/restaurant_data_model.dart';

class FavRestaurantProvider with ChangeNotifier {
  final List<RestaurantModel> _restaurant = [];

  List<RestaurantModel> get restaurants => _restaurant;

  FavRestaurantProvider() {
    _loadRestaurant();
  }

  void addRestaurant(RestaurantModel model) {
    _restaurant.add(model);
    Utils.toastMessage('Restaurant Added');
    _saveRestaurant();
    notifyListeners();
  }

  void removeRestaurant(int id) {
    _restaurant.removeWhere((restaurant) => restaurant.restaurantID == id);
    Utils.toastMessage('Restaurant Removed');
    _saveRestaurant();
    notifyListeners();
  }

  bool isLiked(int id) {
    return _restaurant.any((restaurant) => restaurant.restaurantID == id);
  }
  void clearData() {
    _restaurant.clear();
    _saveRestaurant();
    notifyListeners();
  }

  Future<void> _loadRestaurant() async {
    final prefs = await SharedPreferences.getInstance();
    final String? restaurantString = prefs.getString('restaurants');
    if (restaurantString != null) {
      final List<dynamic> restaurantJson = json.decode(restaurantString);
      _restaurant.clear();
      _restaurant.addAll(restaurantJson
          .map((json) => RestaurantModel.fromJson(json))
          .toList());
      notifyListeners();
    }
  }

  Future<void> _saveRestaurant() async {
    final prefs = await SharedPreferences.getInstance();
    final String restaurantString = json
        .encode(_restaurant.map((restaurant) => restaurant.toJson()).toList());
    await prefs.setString('restaurants', restaurantString);
  }
}
