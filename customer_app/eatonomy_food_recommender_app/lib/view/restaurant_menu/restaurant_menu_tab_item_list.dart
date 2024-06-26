import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../res/components/Colors/colors_app.dart';
import '../../res/components/HomePage_Components/dish_card.dart';
import '../cart/persistent_shopping_cart.dart';
import '../product_details/product_details_widget.dart';

class TabItemList extends StatefulWidget {
  final String foodCategory;
  final int id;

  const TabItemList({super.key, required this.foodCategory, required this.id});

  @override
  State<TabItemList> createState() => _TabItemListState();
}

class _TabItemListState extends State<TabItemList> {
  late Stream<QuerySnapshot> categoryDataStream;

  @override
  void initState() {
    super.initState();
    categoryDataStream = FirebaseFirestore.instance
        .collection(widget.foodCategory)
        .where('id', isEqualTo: widget.id)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: categoryDataStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                  var category = snapshot.data!.docs[index];

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DishCard(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailsWidget(
                                      restaurantID: category['id'],
                                      productID: category['did'],
                                      imageurl: category['imageurl'],
                                      productName: category['title'],
                                      price: category['price'],
                                      isDeliveryFree: category['delivery free'],
                                      rating: category['rating'],
                                      numberOfReviews: category['reviews'],
                                      deliveryTime: category['delivery time'],
                                      description: category['description'],
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
                                                      textAlign:
                                                          TextAlign.center,
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
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0),
                                                    ),
                                                  ),
                                                ),
                                                product:
                                                    PersistentShoppingCartItem(
                                                        productId:
                                                            category['did']
                                                                .toString(),
                                                        productName:
                                                            category['title'],
                                                        productThumbnail:
                                                            category[
                                                                'imageurl'],
                                                        unitPrice: double.parse(
                                                            category['price']
                                                                .toString()),
                                                        quantity: 1)),
                                      ),
                                      calories: category['calories'],
                                    )));
                      },
                      imageUrl: category['imageurl'],
                      productName: category['title'],
                      price: category['price'],
                      restaurantID: category['id'],
                      dishID: category['did'],
                      isDeliveryFree: category['delivery free'],
                      rating: category['rating'],
                      numberOfReviews: category['reviews'],
                      deliveryTime: category['delivery time'],
                      description: category['description'],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
