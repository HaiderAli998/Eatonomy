import 'package:eatonomy_admin_panel_app/utils/routes/routes_name.dart';
import 'package:eatonomy_admin_panel_app/view/home_screen/home_widget.dart';
import 'package:eatonomy_admin_panel_app/view/splash_screen/splash_screen_widget.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
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