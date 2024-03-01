import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:eatonomy_food_recommender_app/view/home_screen.dart';
import 'package:eatonomy_food_recommender_app/view/food_preferences_screen.dart';
import 'package:eatonomy_food_recommender_app/view/forget_screen.dart';
import 'package:eatonomy_food_recommender_app/view/login_screen.dart';
import 'package:eatonomy_food_recommender_app/view/signup_screen.dart';
import 'package:eatonomy_food_recommender_app/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case RoutesName.signUP:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupScreen());
      case RoutesName.foodPreferences:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FoodPreferences());
      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RoutesName.forgetScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgetScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No Routes Found'),
            ),
          );
        });
    }
  }
}
