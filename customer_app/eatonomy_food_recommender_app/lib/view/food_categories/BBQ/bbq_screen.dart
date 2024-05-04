import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../res/components/HomePage_Components/dish_card.dart';

class BBQScreen extends StatefulWidget {
  const BBQScreen({super.key});

  @override
  State<BBQScreen> createState() => _BBQScreenState();
}

class _BBQScreenState extends State<BBQScreen> {
  @override
  Widget build(BuildContext context) {
    final bbqStream = FirebaseFirestore.instance.collection('BBQ').snapshots();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'BBQ',
              style: TextStyle(
                  color: ColorsApp.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          backgroundColor: ColorsApp.backgroundColorApp,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: bbqStream,
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
                    var bbqData = snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DishCard(
                        onTap: () {},
                        imageUrl: 'https://picsum.photos/seed/435/600',
                        productName: bbqData['title'],
                        price: bbqData['price'],
                        isDeliveryFree: bbqData['delivery free'],
                        rating: bbqData['rating'],
                        numberOfReviews: bbqData['reviews'],
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
