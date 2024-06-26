import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';

class CartProvider extends ChangeNotifier {
  List<PersistentShoppingCartItem> _cartItems = [];

  List<PersistentShoppingCartItem> get cartItems => _cartItems;

  void setCartItems(List<PersistentShoppingCartItem> items) {
    _cartItems = items;
    notifyListeners();
  }
}
