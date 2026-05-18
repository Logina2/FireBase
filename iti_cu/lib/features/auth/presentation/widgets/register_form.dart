import 'package:flutter/material.dart';
import 'package:iti_cu/core/common_model/app_user.dart';
import 'package:iti_cu/core/common_widgets/app_button.dart';
import 'package:iti_cu/core/common_widgets/app_text_field.dart';
import 'package:iti_cu/core/services/firebase_auth_service.dart';
import 'package:iti_cu/core/services/firebase_firestore_service.dart';
import 'package:iti_cu/core/utils/app_validator.dart';
import 'package:iti_cu/features/main/presentation/screens/main_screen.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();
  bool isLoading = false;
  String? error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    _confirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(title: 'Full Name', controller: _name),
          const SizedBox(height: 12),
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
          const SizedBox(height: 12),
          AppTextField(
            title: 'Confirm Password',
            controller: _confirm,
            isPasswordField: true,
            validator: (v) =>
                AppValidator.validateConfirmPassword(v, _pass.text),
          ),
          const SizedBox(height: 24),
          if (error != null)
            Text(error!, style: const TextStyle(color: Colors.red)),
          AppButton(
            label: isLoading ? 'Loading...' : 'Sign Up',
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                  error = null;
                });
                try {
                  final u = await FirebaseAuthService.register(
                    _email.text.trim(),
                    _pass.text,
                  );
                  if (u != null) {
                    await FirebaseFirestoreService.saveUserData(
                      AppUser(
                        name: _name.text.trim(),
                        profilePic: '',
                        token: '',
                        email: _email.text.trim(),
                        uid: u.uid,
                      ),
                    );
                  }
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
