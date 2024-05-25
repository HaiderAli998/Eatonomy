import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view/provider/recommended_category_provider.dart';
import '../Colors/colors_app.dart';

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

  void _handleTap() {
    setState(() {
      flag = !flag;
    });

    var provider =
        Provider.of<RecommendedCategoryProvider>(context, listen: false);

    if (flag) {
      provider.addCategory(widget.text);
      Utils.toastMessage('Data Added');
    } else {
      provider.removeCategory(widget.text);
      Utils.toastMessage('Data Removed');
    }

    if (widget.onContainerPressed != null) {
      widget.onContainerPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _handleTap,
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
