import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/Custom_button.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:eatonomy_food_recommender_app/view/cart/persistent_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgAlertDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            'assets/icons/tick_icon_orange_background.svg',
            // Ensure the correct path to your SVG file
            height: 150,
            width: 150,
          ),
          const Text(
            'Thank You!',
            style: TextStyle(
                color: ColorsApp.splashBackgroundColorApp,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          const Text(
            'Your Order has been\nsuccessfully placed',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.0, // Adjust font size as needed
                color: ColorsApp.lightGrey // Adjust font weight as needed
                ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              'Order on the Way',
              () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RoutesName.navBarScreen, (Route route) => false);
                PersistentShoppingCart().clearCart();
              },
              ColorsApp.splashBackgroundColorApp,
              isEnabled: true,
            ),
          ),
        ],
      ),
    );
  }
}
