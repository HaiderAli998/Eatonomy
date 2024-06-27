import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/components/Colors/colors_app.dart';
import '../../res/components/HomePage_Components/restaurants_card.dart';
import '../provider/recommended_category_provider.dart';
import '../restaurant_menu/restaurant_menu_widget.dart';

class RecommendedListView extends StatelessWidget {
  final Stream<QuerySnapshot> restaurantDataStream;

  const RecommendedListView({super.key, required this.restaurantDataStream});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecommendedCategoryProvider>(
      builder: (context, provider, child) {
        return StreamBuilder<QuerySnapshot>(
          stream: restaurantDataStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No Data Available'));
            } else {
              var userPreferences = provider.recommendedCategories;
              var allRestaurants = snapshot.data!.docs;
              var recommendedRestaurantIds = getAIRecommendedRestaurantIds(
                  userPreferences, allRestaurants);

              var filteredRestaurants = allRestaurants.where((doc) {
                return recommendedRestaurantIds.contains(doc.id);
              }).toList();

              if (filteredRestaurants.isEmpty) {
                return const Center(
                    child: Text('No recommended restaurants found'));
              }

              return Container(
                width: 100.0,
                height: MediaQuery.of(context).size.height * 0.275,
                decoration: const BoxDecoration(
                  color: ColorsApp.backgroundColorApp,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: filteredRestaurants.length,
                  itemBuilder: (BuildContext context, int index) {
                    var restaurantData = filteredRestaurants[index];

                    return CustomRestaurantCard(
                      imageUrl: restaurantData['imageurl'],
                      restaurantName: restaurantData['title'],
                      rating: restaurantData['rating'],
                      numberOfReviews: restaurantData['numberOfReviews'],
                      isDeliveryFree: false,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RestaurantMenuWidget(
                              imageUrl: restaurantData['imageurl'],
                              id: restaurantData['id'],
                              restaurantName: restaurantData['title'],
                              openingHours: const ['2:00-12:00', '2:00-2:00'],
                              categories:
                                  List.from(restaurantData['Categories']),
                              rating: restaurantData['rating'],
                              deliveryTime: restaurantData['delivery time'],
                            ),
                          ),
                        );
                      },
                      foodCategories: List.from(restaurantData['Categories']),
                      deliveryTime: restaurantData['delivery time'],
                      id: restaurantData['id'],
                      openingHours: const ['2:00-12:00', '2:00-2:00'],
                    );
                  },
                ),
              );
            }
          },
        );
      },
    );
  }
}

// Mock AI Recommendation Service
List<String> getAIRecommendedRestaurantIds(
    List<String> userPreferences, List<DocumentSnapshot> allRestaurants) {
  // This function returns restaurant IDs that match all user preferences.

  List<String> recommendedRestaurantIds = [];

  for (var restaurant in allRestaurants) {
    var restaurantCategories = List<String>.from(restaurant['Categories']);
    if (userPreferences
        .every((preference) => restaurantCategories.contains(preference))) {
      recommendedRestaurantIds.add(restaurant.id);
    }
  }

  return recommendedRestaurantIds;
}
