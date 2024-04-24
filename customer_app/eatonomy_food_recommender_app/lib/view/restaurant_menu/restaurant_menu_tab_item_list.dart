import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../flutter_flow/flutter_flow_theme.dart';
import '../../res/components/HomePage_Components/dish_card.dart';
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
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: categoryDataStream,
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
                    var category = snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DishCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetailsWidget(
                                        imageurl: category['imageurl'],
                                        productName: category['title'],
                                        price: category['price'],
                                        isDeliveryFree:
                                            category['delivery free'],
                                        rating: category['rating'],
                                        numberOfReviews: category['reviews'],
                                        deliveryTime: category['delivery time'],
                                        description: category['description'],
                                      )));
                        },
                        imageUrl: category['imageurl'],
                        productName: category['title'],
                        price: category['price'],
                        isDeliveryFree: category['delivery free'],
                        rating: category['rating'],
                        numberOfReviews: category['reviews'],
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
