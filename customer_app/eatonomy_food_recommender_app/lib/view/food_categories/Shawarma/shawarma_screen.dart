import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../res/components/HomePage_Components/dish_card.dart';
import '../../../res/components/Colors/colors_app.dart';

class ShawarmaScreen extends StatefulWidget {
  const ShawarmaScreen({super.key});

  @override
  State<ShawarmaScreen> createState() => _ShawarmaScreenState();
}

class _ShawarmaScreenState extends State<ShawarmaScreen> {
  @override
  Widget build(BuildContext context) {
    final shawarmaStream =
        FirebaseFirestore.instance.collection('Shawarma').snapshots();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Shawarma',
              style: TextStyle(
                  color: ColorsApp.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ),
          backgroundColor: ColorsApp.backgroundColorApp,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: shawarmaStream,
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
                    var shawarmaData = snapshot.data!.docs[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Expanded(
                        child: DishCard(
                          onTap: () {},
                          imageUrl: 'https://picsum.photos/seed/435/600',
                          productName: shawarmaData['title'],
                          price: shawarmaData['price'],
                          isDeliveryFree: shawarmaData['delivery free'],
                          rating: shawarmaData['rating'],
                          numberOfReviews: shawarmaData['reviews'],
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
