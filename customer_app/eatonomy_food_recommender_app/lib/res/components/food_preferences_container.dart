  import 'package:flutter/material.dart';

  import 'colors_app.dart';

  class FoodPreferencesContainer extends StatefulWidget {
    final String text;

    const FoodPreferencesContainer({Key? key, required this.text})
        : super(key: key);

    @override
    State<FoodPreferencesContainer> createState() =>
        _FoodPreferencesContainerState();
  }

  class _FoodPreferencesContainerState extends State<FoodPreferencesContainer> {
    @override
    Widget build(BuildContext context) {
      return Container(
        height: 30,
        width: 96,
        decoration: BoxDecoration(
          color: ColorsApp.backgroundColorApp,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ColorsApp.neutralN60,
          ),
        ),
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              widget.text,
              style: const TextStyle(color: ColorsApp.neutralN60),
            ),
          ),
        ),
      );
    }
  }
