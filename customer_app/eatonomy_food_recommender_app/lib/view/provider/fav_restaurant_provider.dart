import 'package:eatonomy_food_recommender_app/view/data_model/restaurant_data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../utils/Utils.dart';

class FavRestaurantProvider with ChangeNotifier {
  final List<RestaurantModel> _restaurant = [];

  List<RestaurantModel> get restaurants => _restaurant;

  void addRestaurant(RestaurantModel model) {
    _restaurant.add(model);
    Utils.toastMessage('ADD Data');
    notifyListeners();
  }

  void removeRestaurant(int id) {
    _restaurant.removeWhere((restaurant) => restaurant.restaurantID == id);
    Utils.toastMessage('Dish removed');
    notifyListeners();
  }

  bool isLiked(int id) {
    return _restaurant.any((restaurant) => restaurant.restaurantID == id && restaurant.isLiked);
  }
}
