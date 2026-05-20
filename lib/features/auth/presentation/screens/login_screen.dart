import 'package:flutter/material.dart';
import 'package:iti_cu/core/common_widgets/app_rich_text.dart';
import 'package:iti_cu/features/auth/presentation/widgets/login_form.dart';
import 'package:iti_cu/features/auth/presentation/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoginForm(),
              const SizedBox(height: 16),
              AppRichText(
                text1: "Don't have an account? ",
                text2: "Sign Up",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RegisterScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
