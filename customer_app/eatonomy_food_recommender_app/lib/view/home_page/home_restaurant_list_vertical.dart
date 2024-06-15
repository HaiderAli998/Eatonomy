import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../res/components/Colors/colors_app.dart';
import '../../res/components/HomePage_Components/restaurants_card.dart';
import '../restaurant_menu/restaurant_menu_widget.dart';

class RestaurantListViewVertical extends StatelessWidget {
  final String appBarTitle;

  const RestaurantListViewVertical({super.key, required this.appBarTitle});

  @override
  Widget build(BuildContext context) {
    final restaurantData =
        FirebaseFirestore.instance.collection('Restaurants').snapshots();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          appBarTitle,
          style: const TextStyle(
              color: ColorsApp.grey, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: ColorsApp.backgroundColorApp,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: restaurantData,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No Restaurants Found'));
          } else {
            return ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var restaurantData = snapshot.data!.docs[index];
                var imageUrl = restaurantData['imageurl'] ?? '';
                var restaurantName = restaurantData['title'] ?? 'No Name';
                var rating = restaurantData['rating'] ?? 0.0;
                var numberOfReviews = restaurantData['numberOfReviews'] ?? 0;
                var categories =
                    List<String>.from(restaurantData['Categories'] ?? []);
                var deliveryTime = restaurantData['delivery time'] ?? 'Unknown';

                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CustomRestaurantCard(
                    imageUrl: imageUrl,
                    restaurantName: restaurantName,
                    rating: rating,
                    numberOfReviews: numberOfReviews,
                    isDeliveryFree: false,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RestaurantMenuWidget(
                            imageUrl: imageUrl,
                            id: restaurantData['id'],
                            restaurantName: restaurantName,
                            openingHours: const ['2:00-12:00', '2:00-2:00'],
                            categories: categories,
                            rating: rating,
                            deliveryTime: deliveryTime,
                          ),
                        ),
                      );
                    },
                    foodCategories: categories,
                    deliveryTime: deliveryTime,
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
