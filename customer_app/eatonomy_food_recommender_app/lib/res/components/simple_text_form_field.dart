import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final String hintText;
  final IconData prefixIcon;
  final Function(String) onFieldSubmitted;

  const SimpleTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
    required this.hintText,
    required this.prefixIcon,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            size: 25,
            color: focusNode.hasFocus
                ? ColorsApp.splashBackgroundColorApp
                : Colors.grey,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 2, color: ColorsApp.splashBackgroundColorApp),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter desired input';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
