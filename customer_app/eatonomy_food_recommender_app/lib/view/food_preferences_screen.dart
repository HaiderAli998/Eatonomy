import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:eatonomy_food_recommender_app/res/components/food_preferences_container.dart';
import 'package:eatonomy_food_recommender_app/res/components/round_button.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FoodPreferences extends StatefulWidget {
  const FoodPreferences({super.key});

  @override
  State<FoodPreferences> createState() => _FoodPreferencesState();
}

class _FoodPreferencesState extends State<FoodPreferences> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 17),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.arrow_back),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.homeScreen);
                },
                child: const Text(
                  'Skip',
                  style: TextStyle(
                      color: ColorsApp.splashBackgroundColorApp, fontSize: 16),
                ),
              )
            ],
          ),
          SizedBox(
            height: height * .040,
          ),
          const Text(
            'Select Food Preferences',
            style: TextStyle(
                fontSize: 24,
                color: ColorsApp.darkGrey,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: height * .002,
          ),
          const Text(
            'Your Food journey begins with your \n preferences',
            style: TextStyle(color: ColorsApp.darkGrey),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height * .032,
          ),
          SvgPicture.asset(
            'assets/food_preferences_photo.svg',
            height: 194,
            width: 194,
          ),
          SizedBox(
            height: height * .046,
          ),
          const Divider(
            thickness: 2,
            color: ColorsApp.neutralN30,
          ),
          SizedBox(
            height: height * .034,
          ),
          Wrap(
            spacing: width * .010,
            runSpacing: height * .010,
            alignment: WrapAlignment.start,
            children: const [
              FoodPreferencesContainer(text: 'Desi'),
              FoodPreferencesContainer(text: 'Italian'),
              FoodPreferencesContainer(text: 'Japanese'),
              FoodPreferencesContainer(text: 'Chinese'),
              FoodPreferencesContainer(text: 'Mexican'),
              FoodPreferencesContainer(text: 'Italian'),
              FoodPreferencesContainer(text: 'Italian'),
              FoodPreferencesContainer(text: 'Italian'),
            ],
          ),
          SizedBox(
            height: height * .080,
          ),
          CustomButton('Continue', () {}, ColorsApp.splashBackgroundColorApp)
        ],
      ),
    )));
  }
}
