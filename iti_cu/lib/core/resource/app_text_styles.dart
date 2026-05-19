import 'package:flutter/material.dart';
import 'package:iti_cu/core/resource/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();
  static const TextStyle grey20Bold = TextStyle(
    color: AppColors.grey,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle grey14Regular = TextStyle(
    color: AppColors.grey,
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle white16Bold = TextStyle(
    color: AppColors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );
}
