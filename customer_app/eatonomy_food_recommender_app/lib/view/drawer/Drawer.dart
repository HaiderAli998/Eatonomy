import 'package:eatonomy_food_recommender_app/res/components/Shared_Preferences/Shared_Preferences.dart';
import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:eatonomy_food_recommender_app/view/address/delivery_address.dart';
import 'package:eatonomy_food_recommender_app/view/provider/fav_dish_provider.dart';
import 'package:eatonomy_food_recommender_app/view/provider/fav_restaurant_provider.dart';
import 'package:eatonomy_food_recommender_app/view/provider/saved_address_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../res/components/Drawer_Components/Drawer_List_Item.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Drawer(
      backgroundColor: ColorsApp.backgroundColorApp,
      child: ListView(
        children: <Widget>[
          FutureBuilder<String?>(
            future: SharedPreferencesClass.getProfilePicture(),
            builder: (context, pictureSnapshot) {
              if (pictureSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (pictureSnapshot.hasError) {
                return Text(
                    'Error fetching profile picture: ${pictureSnapshot.error}');
              } else {
                return FutureBuilder<String?>(
                  future: SharedPreferencesClass.getProfileName(),
                  builder: (context, nameSnapshot) {
                    if (nameSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (nameSnapshot.hasError) {
                      return Text(
                          'Error fetching profile name: ${nameSnapshot.error}');
                    } else {
                      return UserAccountsDrawerHeader(
                        accountName: FutureBuilder<String?>(
                          future: SharedPreferencesClass.getProfileName(),
                          builder: (context, nameSnapshot) {
                            if (nameSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (nameSnapshot.hasError) {
                              return Text(
                                  'Error fetching profile name: ${nameSnapshot.error}');
                            } else {
                              String? profileName = nameSnapshot.data;
                              if (profileName == null) {
                                return FutureBuilder<String?>(
                                  future: SharedPreferencesClass
                                      .getProfileNameGoogle(),
                                  builder: (context, googleNameSnapshot) {
                                    if (googleNameSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    } else if (googleNameSnapshot.hasError) {
                                      return Text(
                                          'Error fetching Google profile name: ${googleNameSnapshot.error}');
                                    } else {
                                      return Text(
                                          googleNameSnapshot.data ?? 'Unknown');
                                    }
                                  },
                                );
                              } else {
                                return Text(profileName);
                              }
                            }
                          },
                        ),
                        accountEmail:
                            Text('${FirebaseAuth.instance.currentUser?.email}'),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: ColorsApp.backgroundColorApp,
                          backgroundImage: pictureSnapshot.data != null
                              ? NetworkImage(pictureSnapshot.data!)
                              : const AssetImage('assets/default_profile.jpg')
                                  as ImageProvider, // Replace with your default image asset
                        ),
                        decoration: const BoxDecoration(
                          color: ColorsApp.splashBackgroundColorApp,
                        ),
                      );
                    }
                  },
                );
              }
            },
          ),
          GestureDetector(
              child: DrawerListItem(
                icon: Icons.category,
                title: "Preferences",
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.foodPreferences);
                },
              ),
              onTap: () {
                Navigator.pushNamed(context, RoutesName.foodPreferences);
              }),
          GestureDetector(
            child: DrawerListItem(
              icon: Icons.shopping_cart_rounded,
              title: "My Cart",
              onTap: () {
                Navigator.pushNamed(context, RoutesName.cartScreen);
              },
            ),
            onTap: () {
              Navigator.pushNamed(context, RoutesName.cartScreen);
            },
          ),
          DrawerListItem(
            icon: Icons.add_location,
            title: "Delivery Address",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      DeliveryAddress(ButtonVisibility: false)));
            },
          ),
          DrawerListItem(
            icon: Icons.payment,
            title: "Payment Methods",
            onTap: () {},
          ),
          DrawerListItem(
            icon: Icons.help_outline_rounded,
            title: "Help",
            onTap: () {},
          ),
          SizedBox(
            height: height * 0.25,
          ),
          const Expanded(
              child: SizedBox(
            height: 15,
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                Provider.of<FavRestaurantProvider>(context, listen: false)
                    .clearData();
                Provider.of<DishProvider>(context, listen: false).clearData();
                Provider.of<SavedAddressProvider>(context, listen: false)
                    .clearData();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    RoutesName.login, (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
