import 'package:flutter/foundation.dart'; // For VoidCallback

class DishModel {
  final String imageUrl;
  final String productName;
  final String calories;
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

  DishModel(
      {required this.imageUrl,
      required this.productName,
      required this.price,
      required this.calories,
      required this.isDeliveryFree,
      required this.isLiked,
      required this.rating,
      required this.numberOfReviews,
      required this.onTap,
      required this.dishID,
      required this.restaurantID,
      required this.description,
      required this.deliveryTime});

  Map<String, dynamic> toJson() => {
        'imageUrl': imageUrl,
        'productName': productName,
        'price': price,
        'restaurantID': restaurantID,
        'dishID': dishID,
        'isLiked': isLiked,
        'isDeliveryFree': isDeliveryFree,
        'rating': rating,
        'numberOfReviews': numberOfReviews,
        'description': description,
        'deliveryTime': deliveryTime,
        'calories': calories
      };

  static DishModel fromJson(Map<String, dynamic> json, VoidCallback onTap) =>
      DishModel(
        imageUrl: json['imageUrl'],
        productName: json['productName'],
        price: json['price'],
        restaurantID: json['restaurantID'],
        dishID: json['dishID'],
        isLiked: json['isLiked'],
        isDeliveryFree: json['isDeliveryFree'],
        rating: json['rating'],
        numberOfReviews: json['numberOfReviews'],
        description: json['description'],
        deliveryTime: json['deliveryTime'],
        onTap: onTap,
        calories: json['calories'],
      );
}
