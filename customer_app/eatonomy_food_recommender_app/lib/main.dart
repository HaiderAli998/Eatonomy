import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:eatonomy_food_recommender_app/res/route_observer.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:eatonomy_food_recommender_app/view/cart/persistent_shopping_cart.dart';
import 'package:eatonomy_food_recommender_app/view/no_internet/connectivity_provider.dart';
import 'package:eatonomy_food_recommender_app/view/no_internet/no_internet_widget.dart';
import 'package:eatonomy_food_recommender_app/view/orders/recent_order_provider.dart';
import 'package:eatonomy_food_recommender_app/view/provider/fav_dish_provider.dart';
import 'package:eatonomy_food_recommender_app/view/provider/fav_restaurant_provider.dart';
import 'package:eatonomy_food_recommender_app/view/provider/recommended_category_provider.dart';
import 'package:eatonomy_food_recommender_app/view/provider/saved_address_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'flutter_flow/flutter_flow_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await PersistentShoppingCart().init();
  await FlutterFlowTheme.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FavRestaurantProvider()),
        ChangeNotifierProvider(create: (_) => DishProvider()),
        ChangeNotifierProvider(create: (_) => RecommendedCategoryProvider()),
        ChangeNotifierProvider(create: (_) => SavedAddressProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: Consumer<ConnectivityProvider>(
        builder: (context, connectivityProvider, child) {
          return Directionality(
            textDirection: TextDirection.ltr, // Specify the text direction
            child: Stack(
              children: [
                MaterialApp(
                  navigatorObservers: [routeObserver],
                  title: 'Flutter Demo',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    useMaterial3: true,
                    colorScheme: ColorScheme.fromSeed(
                      seedColor: ColorsApp.backgroundColorApp,
                    ).copyWith(surface: ColorsApp.backgroundColorApp),
                  ),
                  initialRoute: RoutesName.splash,
                  onGenerateRoute: Routes.generateRoute,
                ),
                if (!connectivityProvider.isConnected)
                  const Positioned.fill(
                    child: NoInternetWidget(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
