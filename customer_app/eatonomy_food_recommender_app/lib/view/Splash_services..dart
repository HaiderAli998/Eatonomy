import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../utils/routes/routes_name.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(
              context, RoutesName.foodPreferences));
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, RoutesName.login));
    }
  }
}
