import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view/provider/fav_restaurant_provider.dart';
import '../../res/components/HomePage_Components/restaurants_card.dart';
import '../../../view/restaurant_menu/restaurant_menu_widget.dart';

class FavRestaurants extends StatefulWidget {
  const FavRestaurants({super.key});

  @override
  State<FavRestaurants> createState() => _FavRestaurantsState();
}

class _FavRestaurantsState extends State<FavRestaurants> {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider =
        Provider.of<FavRestaurantProvider>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: restaurantProvider.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = restaurantProvider.restaurants[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              child: CustomRestaurantCard(
                id: restaurant.restaurantID,
                imageUrl: restaurant.imageUrl,
                restaurantName: restaurant.restaurantName,
                isDeliveryFree: restaurant.isDeliveryFree,
                rating: restaurant.rating,
                numberOfReviews: restaurant.numberOfReviews,
                deliveryTime: restaurant.deliveryTime,
                foodCategories: restaurant.foodCategories,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RestaurantMenuWidget(
                        restaurantName: restaurant.restaurantName,
                        openingHours: restaurant.openingHours,
                        rating: restaurant.rating,
                        deliveryTime: restaurant.deliveryTime,
                        categories: restaurant.foodCategories,
                        id: restaurant.restaurantID,
                        imageUrl: restaurant.imageUrl,
                      ),
                    ),
                  );
                },
                openingHours: restaurant.openingHours,
              ),
            );
          },
        ),
      ),
    );
  }
}
