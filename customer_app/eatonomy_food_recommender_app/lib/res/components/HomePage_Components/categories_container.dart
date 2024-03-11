import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../colors_app.dart';

class CustomCategoryContainer extends StatelessWidget {
  final String svgPath;
  final String text;
  final VoidCallback onTap;

  const CustomCategoryContainer({
    super.key,
    required this.svgPath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: const BoxDecoration(),
        child: Column(
          children: [
            SvgPicture.asset(
              svgPath,
              fit: BoxFit.contain,
              height: 40,
              width: 32,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              text,
              style: const TextStyle(
                color: ColorsApp.neutralN200,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
