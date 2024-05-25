import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../res/components/Colors/colors_app.dart';
import '../../res/components/HomePage_Components/dish_card.dart';
import '../cart/persistent_shopping_cart.dart';
import '../product_details/product_details_widget.dart';

class HomePopularItems extends StatelessWidget {
  final Stream<QuerySnapshot> popularItemsStream;

  const HomePopularItems({super.key, required this.popularItemsStream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: popularItemsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No Data Available');
        } else {
          return Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            height: MediaQuery.of(context).size.height * 0.275,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var categoryData = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DishCard(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsWidget(
                                    productID: categoryData['did'],
                                    restaurantID: categoryData['id'],
                                    imageurl: categoryData['imageurl'],
                                    productName: categoryData['title'],
                                    price: categoryData['price'],
                                    isDeliveryFree:
                                        categoryData['delivery free'],
                                    rating: categoryData['rating'],
                                    numberOfReviews: categoryData['reviews'],
                                    deliveryTime: categoryData['delivery time'],
                                    description: categoryData['description'],
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
                                                      productId:
                                                          categoryData['id']
                                                              .toString(),
                                                      productName:
                                                          categoryData['title'],
                                                      productThumbnail:
                                                          categoryData[
                                                              'imageurl'],
                                                      unitPrice: double.parse(
                                                          categoryData['price']
                                                              .toString()),
                                                      quantity: 1)),
                                    ),
                                  )));
                    },
                    imageUrl: categoryData['imageurl'],
                    restaurantID: categoryData['id'],
                    dishID: categoryData['did'],
                    productName: categoryData['title'],
                    price: categoryData['price'],
                    isDeliveryFree: categoryData['delivery free'],
                    rating: categoryData['rating'],
                    numberOfReviews: categoryData['reviews'],
                    deliveryTime: categoryData['delivery time'],
                    description: categoryData['description'],
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
