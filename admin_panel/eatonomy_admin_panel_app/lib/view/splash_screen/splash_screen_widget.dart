import 'package:eatonomy_admin_panel_app/view/splash_screen/splash_screen_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../res/colors/colors_app.dart';

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
            'assets/icons/app_logo_splash_screen.svg',
            semanticsLabel: 'My SVG Image',
            height: 189,
            width: 189,
          ),
        ));
  }
}
