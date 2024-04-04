import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../flutter_flow/flutter_flow_theme.dart';
import '../../res/components/HomePage_Components/dish_card.dart';

class BurgerScreen extends StatefulWidget {
  const BurgerScreen({super.key});

  @override
  State<BurgerScreen> createState() => _BurgerScreenState();
}

class _BurgerScreenState extends State<BurgerScreen> {
  @override
  Widget build(BuildContext context) {
    final burgerData =
        FirebaseFirestore.instance.collection('Burgers').snapshots();
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<QuerySnapshot>(
          stream: burgerData,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot) {
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

                    return  Padding(
                      padding:  EdgeInsets.all(8.0),
                      child:  DishCard(
                        imageUrl: 'https://picsum.photos/seed/435/600',
                        productName: burgerData['title'],
                        price: burgerData['price'],
                        isDeliveryFree: burgerData['delivery free'],
                        rating: burgerData['rating'],
                        numberOfReviews: burgerData['reviews'],
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
