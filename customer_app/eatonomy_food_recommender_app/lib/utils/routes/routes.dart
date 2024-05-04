import 'package:eatonomy_food_recommender_app/Firestore_screens/firestore_list_screen.dart';
import 'package:eatonomy_food_recommender_app/res/components/Authentication_Components/Login_with_phone_number.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:eatonomy_food_recommender_app/view/cart/cart_widget.dart';
import 'package:eatonomy_food_recommender_app/view/food_categories/BBQ/bbq_screen.dart';
import 'package:eatonomy_food_recommender_app/view/food_categories/Shawarma/shawarma_list_added_code.dart';
import 'package:eatonomy_food_recommender_app/view/home_page/home_screen.dart';
import 'package:eatonomy_food_recommender_app/view/food_preferences/food_preferences_screen.dart';
import 'package:eatonomy_food_recommender_app/view/authentication/forget_screen.dart';
import 'package:eatonomy_food_recommender_app/view/authentication/login_screen.dart';
import 'package:eatonomy_food_recommender_app/view/authentication/signup_screen.dart';
import 'package:eatonomy_food_recommender_app/view/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import '../../Firestore_screens/firestore_add_data.dart';
import '../../view/BottomNavBar.dart';
import '../../view/food_categories/Burgers/burger_screen_list.dart';

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
      case RoutesName.navBarScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const NavBarPage());
      case RoutesName.forgetScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ForgetScreen());
      case RoutesName.loginPhone:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginWithPhoneNumber());
      case RoutesName.fireStoreScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FireStoreScreen());
      case RoutesName.fireStoreAdd:
        return MaterialPageRoute(
            builder: (BuildContext context) => const FireStoreAddData());
      case RoutesName.cartScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CartWidget());
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
