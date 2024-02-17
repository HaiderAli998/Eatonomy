import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialMediaBox extends StatelessWidget {
  final String text;
  final String svgPath;
  final VoidCallback onPress;

  const SocialMediaBox(
      {super.key,
      required this.text,
      required this.onPress,
      required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 44,
        width: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              height: 32,
              width: 32,
            ),
            Text(text)
          ],
        ),
      ),
    );
  }
}
