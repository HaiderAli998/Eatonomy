import 'package:flutter/foundation.dart'; // For VoidCallback

class RestaurantModel {
  final String imageUrl;
  final String restaurantName;
  final int price;
  final int restaurantID;
  final bool isLiked;
  final bool isDeliveryFree;
  final double rating;
  final int numberOfReviews;
  final String description;
  final String deliveryTime;
  final List<String> foodCategories;
  final List<String> openingHours;
  final VoidCallback onTap;

  RestaurantModel(
      {required this.imageUrl,
      required this.restaurantName,
      required this.isDeliveryFree,
      required this.isLiked,
      required this.price,
      required this.openingHours,
      required this.rating,
      required this.numberOfReviews,
      required this.onTap,
      required this.restaurantID,
      required this.description,
      required this.deliveryTime,
      required this.foodCategories});
}
