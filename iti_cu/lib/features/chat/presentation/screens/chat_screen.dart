import 'package:flutter/material.dart';
import 'package:iti_cu/features/chat/presentation/screens/users_list_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats', style: TextStyle(color: Colors.white)),
      ),
      body: const UsersListScreen(),
    );
  }
}
