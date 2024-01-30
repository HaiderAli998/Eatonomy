import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color buttonColor;
  final VoidCallback onPress;

  const CustomButton(this.text, this.onPress, this.buttonColor, {super.key});

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
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
