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
  final VoidCallback? onTap; // Made optional

  RestaurantModel({
    required this.imageUrl,
    required this.restaurantName,
    required this.isDeliveryFree,
    required this.isLiked,
    required this.price,
    required this.openingHours,
    required this.rating,
    required this.numberOfReviews,
    this.onTap, // Optional
    required this.restaurantID,
    required this.description,
    required this.deliveryTime,
    required this.foodCategories,
  });

  Map<String, dynamic> toJson() => {
    'imageUrl': imageUrl,
    'restaurantName': restaurantName,
    'price': price,
    'restaurantID': restaurantID,
    'isLiked': isLiked,
    'isDeliveryFree': isDeliveryFree,
    'rating': rating,
    'numberOfReviews': numberOfReviews,
    'description': description,
    'deliveryTime': deliveryTime,
    'openingHours': openingHours,
    'foodCategories': foodCategories,
  };

  static RestaurantModel fromJson(Map<String, dynamic> json) => RestaurantModel(
    imageUrl: json['imageUrl'],
    restaurantName: json['restaurantName'],
    price: json['price'],
    restaurantID: json['restaurantID'],
    isLiked: json['isLiked'],
    isDeliveryFree: json['isDeliveryFree'],
    rating: json['rating'],
    numberOfReviews: json['numberOfReviews'],
    description: json['description'],
    deliveryTime: json['deliveryTime'],
    openingHours: List<String>.from(json['openingHours']),
    foodCategories: List<String>.from(json['foodCategories']),
    onTap: null, // Optional, handle tap elsewhere if necessary
  );
}
