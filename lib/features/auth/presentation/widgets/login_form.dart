import 'package:flutter/material.dart';
import 'package:iti_cu/core/common_widgets/app_button.dart';
import 'package:iti_cu/core/common_widgets/app_text_field.dart';
import 'package:iti_cu/core/services/firebase_auth_service.dart';
import 'package:iti_cu/core/utils/app_validator.dart';
import 'package:iti_cu/features/main/presentation/screens/main_screen.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            title: 'Email Address',
            controller: _email,
            validator: AppValidator.validateEmail,
          ),
          const SizedBox(height: 12),
          AppTextField(
            title: 'Password',
            controller: _pass,
            isPasswordField: true,
            validator: AppValidator.validatePassword,
          ),
          const SizedBox(height: 24),
          if (error != null)
            Text(error!, style: const TextStyle(color: Colors.red)),
          AppButton(
            label: isLoading ? 'Loading...' : 'Login',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                  error = null;
                });
                try {
                  await FirebaseAuthService.login(
                    _email.text.trim(),
                    _pass.text,
                  );
                  if (!mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                  );
                } catch (e) {
                  setState(() => error = e.toString());
                } finally {
                  setState(() => isLoading = false);
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
