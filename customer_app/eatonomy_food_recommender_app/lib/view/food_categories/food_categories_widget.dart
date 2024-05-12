import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../res/components/HomePage_Components/dish_card.dart';
import '../../res/components/Colors/colors_app.dart';
import '../cart/persistent_shopping_cart.dart';
import '../product_details/product_details_widget.dart';

class CategoryScreen extends StatefulWidget {
  final Stream<QuerySnapshot> dataStream;
  final String appBarTitle;

  const CategoryScreen({
    super.key,
    required this.dataStream,
    required this.appBarTitle,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text(
              widget.appBarTitle,
              style: const TextStyle(
                  color: ColorsApp.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          backgroundColor: ColorsApp.backgroundColorApp,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: widget.dataStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData) {
              return const Text('No Data Available');
            } else {
              return Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var categoryData = snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
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
                                          numberOfReviews:
                                              categoryData['reviews'],
                                          deliveryTime:
                                              categoryData['delivery time'],
                                          description:
                                              categoryData['description'],
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
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: const Center(
                                                        child: Text(
                                                          'Removed',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
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
                                                              BorderRadius
                                                                  .circular(
                                                                      30)),
                                                      child: const Center(
                                                        child: Text(
                                                          'ADD TO CART',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.0),
                                                        ),
                                                      ),
                                                    ),
                                                    product: PersistentShoppingCartItem(
                                                        productId:
                                                            categoryData['id']
                                                                .toString(),
                                                        productName:
                                                            categoryData[
                                                                'title'],
                                                        productThumbnail:
                                                            categoryData[
                                                                'imageurl'],
                                                        unitPrice: double.parse(
                                                            categoryData[
                                                                    'price']
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
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
