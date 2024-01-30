import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  //function help to change the focus from one TextField to other while clicking done
  static void fieldFocusChange(BuildContext context, FocusNode nextNode) {
    FocusScope.of(context).requestFocus(nextNode);
  }

  //toast message
  static toastMessage(String message) {
    Fluttertoast.showToast(msg: message);
  }

  // flush bar message
  static flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          message: message,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error, color: Colors.white),
          duration: const Duration(seconds: 3),
          //animations
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
        )..show(context));
  }

  static showSnackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }
}
