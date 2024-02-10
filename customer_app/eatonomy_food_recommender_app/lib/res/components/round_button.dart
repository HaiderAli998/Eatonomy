import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final bool loading;
  final VoidCallback onPress;

  const CustomButton(
    this.text,
    this.onPress,
    this.buttonColor, {
    this.loading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 48,
        width: 368,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(strokeWidth: 3,color: ColorsApp.backgroundColorApp,)
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 16.0),
                ),
        ),
      ),
    );
  }
}
