import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatonomy_food_recommender_app/view/restaurant_menu/restaurant_menu_widget.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../res/components/Colors/colors_app.dart';
import '../../res/components/HomePage_Components/restaurants_card.dart';

class AllRestaurants extends StatefulWidget {
  const AllRestaurants({super.key});

  @override
  State<AllRestaurants> createState() => _AllRestaurantsState();
}

class _AllRestaurantsState extends State<AllRestaurants> {
  final restaurantData =
      FirebaseFirestore.instance.collection('Restaurants').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Restaurants',
            style: TextStyle(
                color: ColorsApp.grey,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
        ),
        backgroundColor: ColorsApp.backgroundColorApp,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: restaurantData,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No Data Available');
          } else {
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var restaurantData = snapshot.data!.docs[index];

                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                  child: CustomRestaurantCard(
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
                                    openingHours: const [
                                      '2:00-12:00',
                                      '2:00-2:00'
                                    ],
                                    categories:
                                        List.from(restaurantData['Categories']),
                                    rating: restaurantData['rating'],
                                    deliveryTime:
                                        restaurantData['delivery time'],
                                  )));
                    },
                    foodCategories: List.from(restaurantData['Categories']),
                    deliveryTime: restaurantData['delivery time'],
                    id: restaurantData['id'],
                    openingHours: const ['2:00-12:00', '2:00-2:00'],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
