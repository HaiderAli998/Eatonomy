import 'package:flutter/material.dart';

import '../../res/colors/colors_app.dart';
import '../../res/custom_containers/Custom_button.dart';
import '../../utils/routes/routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorsApp.backgroundColorApp,
          title: Center(
            child: Text(
              'Eatonomy Admin Panel',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton('ADD Restaurant', () {
                Navigator.pushNamed(context, RoutesName.addRestaurant);
              }, ColorsApp.splashBackgroundColorApp, isEnabled: true),
              SizedBox(
                height: 5,
              ),
              CustomButton(
                  'ADD Dish', () {}, ColorsApp.splashBackgroundColorApp,
                  isEnabled: true)
            ],
          ),
        ));
  }
}
