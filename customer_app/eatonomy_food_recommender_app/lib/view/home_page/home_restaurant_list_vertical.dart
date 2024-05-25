import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../res/components/HomePage_Components/restaurants_card.dart';
import '../restaurant_menu/restaurant_menu_widget.dart';

class RestaurantListViewVertical extends StatelessWidget {
  final Stream<QuerySnapshot> restaurantDataStream;
  final String appBarTitle;

  const RestaurantListViewVertical(
      {super.key, required this.restaurantDataStream, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            appBarTitle,
            style: const TextStyle(
                color: ColorsApp.grey, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        backgroundColor: ColorsApp.backgroundColorApp,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: restaurantDataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print('Connection State: ${snapshot.connectionState}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Loading data...');
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            print('No data available');
            return const Center(child: Text('No Data Available'));
          } else if (snapshot.data!.docs.isEmpty) {
            print('No restaurants found');
            return const Center(child: Text('No Restaurants Found'));
          } else {
            print('Data loaded successfully');
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var restaurantData = snapshot.data!.docs[index];
                print('Restaurant Data: $restaurantData');

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
                          categories: List.from(restaurantData['Categories']),
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
            );
          }
        },
      ),
    );
  }
}
