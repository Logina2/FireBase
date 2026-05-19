import 'package:flutter/material.dart';
import 'package:iti_cu/core/constants/ui_constants.dart';
import 'package:iti_cu/core/services/firebase_auth_service.dart';
import 'package:iti_cu/features/auth/presentation/screens/login_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: UiConstants.accountItems.length,
        itemBuilder: (context, index) {
          final item = UiConstants.accountItems[index];
          return ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title: Text(
              item.title,
              style: const TextStyle(color: Colors.white),
            ),
            onTap: () async {
              if (item.title == 'Logout') {
                await FirebaseAuthService.logout();
                if (!context.mounted) return;
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (r) => false,
                );
              }
            },
          );
        },
      ),
    );
  }
}
