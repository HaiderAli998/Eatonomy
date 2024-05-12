import 'package:flutter/foundation.dart'; // For VoidCallback

class DishModel {
  final String imageUrl;
  final String productName;
  final int price;
  final int restaurantID;
  final int dishID;
  final bool isLiked;
  final bool isDeliveryFree;
  final double rating;
  final int numberOfReviews;
  final String description;
  final String deliveryTime;
  final VoidCallback onTap;

  DishModel({
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.isDeliveryFree,
    required this.isLiked,
    required this.rating,
    required this.numberOfReviews,
    required this.onTap,
    required this.dishID,
    required this.restaurantID,
    required this.description,
    required this.deliveryTime
  });
}
