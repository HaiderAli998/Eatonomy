import 'package:flutter/material.dart';
import '../colors_app.dart';

class FoodPreferencesContainer extends StatefulWidget {
  final String text;
  final Function()? onContainerPressed;

  const FoodPreferencesContainer({
    super.key,
    required this.text,
    required this.onContainerPressed,
  });

  @override
  State<FoodPreferencesContainer> createState() =>
      _FoodPreferencesContainerState();
}

class _FoodPreferencesContainerState extends State<FoodPreferencesContainer> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onContainerPressed != null) {
          widget.onContainerPressed!();
          setState(() {
            flag = !flag;
          });
        }
      },
      child: Container(
        height: 30,
        width: 96,
        decoration: BoxDecoration(
          color: flag ? Colors.white : ColorsApp.backgroundColorApp,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: flag
                ? ColorsApp.splashBackgroundColorApp
                : ColorsApp.neutralN60,
          ),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              widget.text,
              style: const TextStyle(
                color: ColorsApp.neutralN60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
