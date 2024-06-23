import 'package:flutter/cupertino.dart';
import '../../utils/routes/routes_name.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, RoutesName.home);
  }
}
