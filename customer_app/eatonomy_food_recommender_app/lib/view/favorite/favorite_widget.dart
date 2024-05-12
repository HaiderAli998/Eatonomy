import 'package:eatonomy_food_recommender_app/view/drawer/Drawer.dart';

import '../../utils/routes/routes_name.dart';
import '../cart/persistent_shopping_cart.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'favorite_model.dart';
import 'favorite_restaurant.dart';
import 'favourite_dishes.dart';
export 'favorite_model.dart';

class FavoriteWidget extends StatefulWidget {
  const FavoriteWidget({super.key});

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  late FavoriteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FavoriteModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const MyDrawer(),
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          title: Text(
            'Favorite',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: Colors.black,
                  fontSize: 22.0,
                ),
          ),
          leading: IconButton(
            // Add an IconButton as the leading widget to open the drawer
            icon: const Icon(Icons.menu), // Use Icons.menu for the drawer icon
            onPressed: () {
              scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
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
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Restaurants'),
              Tab(
                text: 'Dishes',
              )
            ],
          ),
        ),
        body: const TabBarView(children: [FavRestaurants(), FavDishes()]),
      ),
    );
  }
}
