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
    required this.focusNode,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.prefixIcon,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    double fieldHeight = MediaQuery.of(context).size.height * 0.07;
    return SizedBox(
      height: fieldHeight,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        maxLines: null,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            prefixIcon,
            size: 20,
            color: focusNode.hasFocus
                ? ColorsApp.splashBackgroundColorApp
                : Colors.grey,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: controller.text.isEmpty ? Colors.red : Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: ColorsApp.splashBackgroundColorApp,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorMaxLines: 2,
          // Adjust this based on your UI
          errorStyle: const TextStyle(height: 0.005),
        ),
        onFieldSubmitted: onFieldSubmitted,
        validator: (value) {
          if (value!.isEmpty) {
            return '';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
