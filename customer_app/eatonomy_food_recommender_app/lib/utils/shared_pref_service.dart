import 'dart:convert';
import 'dart:developer';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance = SharedPreferencesService._internal();

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  Future<void> storeObjectList(String key, List<PersistentShoppingCartItem> list) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = list.map((item) => jsonEncode(item.toJson())).toList();
    await prefs.setStringList(key, jsonList);
  }
  //
  // Future<List<PersistentShoppingCartItem>> getObjectList(String key) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final List<String> jsonList = prefs.getStringList(key) ?? [];
  //   return jsonList.map((item) => persistentShoppingCartItemFromJson(jsonDecode(item))).toList();
  // }
  Future<List<PersistentShoppingCartItem>> getObjectList(String key) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String> jsonList = prefs.getStringList(key) ?? [];
  return jsonList.map((item) => persistentShoppingCartItemFromJson(jsonDecode(item))).toList();
  }
}

// Helper function for fromJson
PersistentShoppingCartItem persistentShoppingCartItemFromJson(Map<String, dynamic> json) {
  return PersistentShoppingCartItem(
    productId: json['productId'],
    productName: json['productName'],
    productDescription: json['productDescription'],
    productThumbnail: json['productThumbnail'],
    productImages: List<String>.from(json['productImages'] ?? []),
    unitPrice: json['unitPrice'],
    quantity: json['quantity'],
    productDetails: json['productDetails'],
  );
}
