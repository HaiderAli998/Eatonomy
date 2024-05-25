import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/food_preferences_container.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/Custom_button.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../provider/recommended_category_provider.dart';

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
    var provider =
        Provider.of<RecommendedCategoryProvider>(context, listen: false);
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 17),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  provider.changeTrigger(false);
                  Navigator.pushReplacementNamed(
                      context, RoutesName.navBarScreen);
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
            children: [
              FoodPreferencesContainer(
                text: 'Pizza',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Burgers',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Broast',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Chinese',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'BBQ',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Broast',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Desi',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Ice-Cream',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Sandwich',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Shawarma',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Tea',
                onContainerPressed: () {},
              ),
              FoodPreferencesContainer(
                text: 'Pasta',
                onContainerPressed: () {},
              ),
            ],
          ),
          SizedBox(
            height: height * .080,
          ),
          CustomButton('Continue', () {
            provider.changeTrigger(true);
            Navigator.pushReplacementNamed(context, RoutesName.navBarScreen);
          }, ColorsApp.splashBackgroundColorApp)
        ],
      ),
    )));
  }
}
