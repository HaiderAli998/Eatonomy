import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:flutter/material.dart';

import '../../../utils/routes/routes_name.dart';
import '../../../view/cart/persistent_shopping_cart.dart';

class CustomSliverAppBar extends StatelessWidget {
  final String titleText;
  final String addressText;
  final String currentAddress;
  final Function onCartPressed;

  const CustomSliverAppBar({
    super.key,
    required this.titleText,
    required this.addressText,
    required this.currentAddress,
    required this.onCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: false,
      backgroundColor: ColorsApp.backgroundColorApp,
      // Set your background color here
      iconTheme: const IconThemeData(
        color: Colors.black, // Set your icon color here
      ),
      automaticallyImplyLeading: true,
      title: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: const AlignmentDirectional(-0.09, -1.0),
            child: Text(
              titleText,
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Readex Pro',
                color: ColorsApp
                    .splashBackgroundColorApp, // Set your title color here
              ),
            ),
          ),
          Align(
            alignment: const AlignmentDirectional(-0.09, -0.95),
            child: Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(currentAddress ?? "Address Placeholder",
                    style: const TextStyle(
                      fontSize: 16.0, // Adjust font size as needed
                    )),
              ),
            ),
          ),
        ],
      ),
      actions: [
        PersistentShoppingCart().showCartItemCountWidget(
            cartItemCountWidgetBuilder: (itemCount) => IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.cartScreen);
                },
                icon: Badge(
                  label: Text(itemCount.toString()),
                  child: const Icon(Icons.shopping_bag_outlined),
                )))
      ],
      centerTitle: true,
      elevation: 1.0,
    );
  }
}
