import 'package:eatonomy_food_recommender_app/view/provider/fav_restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavRestaurants extends StatefulWidget {
  const FavRestaurants({super.key});

  @override
  State<FavRestaurants> createState() => _FavRestaurantsState();
}

class _FavRestaurantsState extends State<FavRestaurants> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<FavRestaurantProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return ListView.builder(
            itemCount: value.selectedItems.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  value.removeItem(index);
                },
                leading: const Icon(Icons.person),
                title: Text('item${value.selectedItems[index]}'),
                trailing: const Icon(Icons.favorite),
              );
            });
      },
    ));
  }
}
