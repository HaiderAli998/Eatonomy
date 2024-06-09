import 'package:eatonomy_food_recommender_app/res/components/HomePage_Components/dish_card.dart';
import 'package:eatonomy_food_recommender_app/view/provider/fav_dish_provider.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:provider/provider.dart';

import '../../res/components/Colors/colors_app.dart';
import '../cart/persistent_shopping_cart.dart';
import '../product_details/product_details_widget.dart';

class FavDishes extends StatefulWidget {
  const FavDishes({super.key});

  @override
  State<FavDishes> createState() => _FavDishesState();
}

class _FavDishesState extends State<FavDishes> {
  @override
  Widget build(BuildContext context) {
    final dishProvider = Provider.of<DishProvider>(context,listen: true);
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
            itemCount: dishProvider.dishes.length,
            itemBuilder: (context, index) {
              var dish = dishProvider.dishes[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                child: DishCard(
                    imageUrl: dish.imageUrl,
                    productName: dish.productName,
                    price: dish.price,
                    restaurantID: dish.restaurantID,
                    dishID: dish.dishID,
                    isDeliveryFree: dish.isLiked,
                    rating: dish.rating,
                    numberOfReviews: dish.numberOfReviews,
                    description: dish.description,
                    deliveryTime: dish.deliveryTime,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsWidget(
                                    productID: dish.dishID,
                                    restaurantID: dish.restaurantID,
                                    imageurl: dish.imageUrl,
                                    productName: dish.productName,
                                    price: dish.price,
                                    isDeliveryFree: dish.isDeliveryFree,
                                    rating: dish.rating,
                                    numberOfReviews: dish.numberOfReviews,
                                    deliveryTime: dish.deliveryTime,
                                    description: dish.description,
                                    shoppingCartWidget: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: PersistentShoppingCart()
                                          .showAndUpdateCartItemWidget(
                                              inCartWidget: Container(
                                                height: 48,
                                                width: 368,
                                                decoration: BoxDecoration(
                                                    color: ColorsApp
                                                        .splashBackgroundColorApp,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: const Center(
                                                  child: Text(
                                                    'Removed',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ),
                                              notInCartWidget: Container(
                                                height: 48,
                                                width: 368,
                                                decoration: BoxDecoration(
                                                    color: ColorsApp
                                                        .splashBackgroundColorApp,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: const Center(
                                                  child: Text(
                                                    'ADD TO CART',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ),
                                              product:
                                                  PersistentShoppingCartItem(
                                                      productId: dish.dishID.toString(),
                                                      productName:
                                                          dish.productName,
                                                      productThumbnail:
                                                          dish.imageUrl,
                                                      unitPrice: double.parse(
                                                          dish.price
                                                              .toString()),
                                                      quantity: 1)),
                                    ),
                                  )));
                    }),
              );
            }),
      ),
    );
  }
}
