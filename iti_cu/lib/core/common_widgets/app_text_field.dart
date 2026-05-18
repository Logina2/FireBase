import 'package:flutter/material.dart';
import 'package:iti_cu/core/resource/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool isPasswordField;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    required this.title,
    required this.controller,
    this.isPasswordField = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPasswordField,
      validator: validator,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        labelText: title,
        labelStyle: const TextStyle(color: AppColors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.cyan),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
