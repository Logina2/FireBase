import 'package:flutter/material.dart';
import 'package:iti_cu/core/common_model/app_user.dart';
import 'package:iti_cu/core/services/firebase_auth_service.dart';
import 'package:iti_cu/core/services/firebase_firestore_service.dart';
import 'package:iti_cu/features/chat/presentation/screens/private_chat_screen.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});
  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final String currentUid = FirebaseAuthService.getCurrentUser()!.uid;
  List<AppUser> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final res = await FirebaseFirestoreService.getAllUsers(currentUid);
    setState(() {
      users = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final u = users[index];
                return ListTile(
                  title: Text(
                    u.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    u.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PrivateChatScreen(otherUser: u),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
