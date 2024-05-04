import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../res/components/HomePage_Components/dish_card.dart';
import '../../../res/components/Colors/colors_app.dart';

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
                    var burgerData = snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: DishCard(
                          onTap: () {},
                          imageUrl: 'https://picsum.photos/seed/435/600',
                          productName: burgerData['title'],
                          price: burgerData['price'],
                          isDeliveryFree: burgerData['delivery free'],
                          rating: burgerData['rating'],
                          numberOfReviews: burgerData['reviews'],
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
