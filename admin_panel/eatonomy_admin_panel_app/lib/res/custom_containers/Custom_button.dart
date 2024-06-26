import 'package:flutter/material.dart';

import '../colors/colors_app.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final bool loading;
  final bool isEnabled;
  final VoidCallback onPress;

  const CustomButton(
    this.text,
    this.onPress,
    this.buttonColor, {
    this.loading = false,
    super.key,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onPress : null,
      child: Container(
        height: 48,
        width: 368,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: ColorsApp.backgroundColorApp,
                )
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
