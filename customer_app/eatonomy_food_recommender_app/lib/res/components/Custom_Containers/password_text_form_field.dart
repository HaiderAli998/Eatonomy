import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueNotifier<bool> obscurePassword;
  final String hintText;
  final Function(String)? onFieldSubmitted;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.obscurePassword,
    required this.hintText,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    double fieldHeight = MediaQuery.of(context).size.height * 0.07;
    return SizedBox(
      height: fieldHeight,
      child: ValueListenableBuilder(
        valueListenable: obscurePassword,
        builder: (context, value, child) {
          return TextFormField(
            controller: controller,
            keyboardType: TextInputType.visiblePassword,
            obscureText: value,
            obscuringCharacter: '*',
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(
                Icons.password,
                color: focusNode.hasFocus
                    ? ColorsApp.splashBackgroundColorApp // Customize as needed
                    : Colors.grey,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 2, color: ColorsApp.splashBackgroundColorApp),
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
              errorMaxLines: 2, // Adjust this based on your UI
              errorStyle: const TextStyle(height: 0.005),
              suffixIcon: InkWell(
                onTap: () {
                  obscurePassword.value = !obscurePassword.value;
                },
                child: Icon(obscurePassword.value
                    ? Icons.lock_open_rounded
                    : Icons.visibility),
              ),
            ),
            onFieldSubmitted: onFieldSubmitted,
            validator: (value) {
              if (value!.isEmpty || value.length<6) {
                return '';
              } else {
                return null;
              }
            },
          );
        },
      ),
    );
  }
}
