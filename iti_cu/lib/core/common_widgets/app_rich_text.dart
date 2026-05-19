import 'package:flutter/material.dart';
import 'package:iti_cu/core/resource/app_colors.dart';

class AppRichText extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;

  const AppRichText({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: text1,
          style: const TextStyle(color: AppColors.grey, fontSize: 14),
          children: [
            TextSpan(
              text: text2,
              style: const TextStyle(
                color: AppColors.cyan,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
