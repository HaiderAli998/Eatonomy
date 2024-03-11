import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:eatonomy_food_recommender_app/view/splash_screen/Splash_services..dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorsApp.splashBackgroundColorApp,
        body: Center(
          child: SvgPicture.asset(
            'assets/app_logo_splash_screen.svg',
            semanticsLabel: 'My SVG Image',
            height: 189,
            width: 189,
          ),
        ));
  }
}
