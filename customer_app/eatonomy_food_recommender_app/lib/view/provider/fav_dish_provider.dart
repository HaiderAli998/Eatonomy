import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:flutter/material.dart';

import '../data_model/dish_data_model.dart';

class DishProvider extends ChangeNotifier {
  final List<DishModel> _dishes = [];

  List<DishModel> get dishes => _dishes;

  void addDish(DishModel model) {
    _dishes.add(model);
    Utils.toastMessage('ADD Data');
    notifyListeners();
  }

  void removeDish(int id) {
    _dishes.removeWhere((dish) => dish.dishID == id);
    Utils.toastMessage('Dish removed');
    notifyListeners();
  }

  bool isLiked(int id) {
    return _dishes.any((dish) => dish.dishID == id && dish.isLiked);
  }
}
