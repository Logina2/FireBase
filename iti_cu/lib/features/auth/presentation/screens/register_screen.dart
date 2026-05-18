import 'package:flutter/material.dart';
import 'package:iti_cu/core/common_widgets/app_rich_text.dart';
import 'package:iti_cu/features/auth/presentation/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const RegisterForm(),
              const SizedBox(height: 16),
              AppRichText(
                text1: "Already have an account? ",
                text2: "Login",
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
