import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iti_cu/core/common_model/app_user.dart';
import 'package:iti_cu/core/resource/app_colors.dart';
import 'package:iti_cu/core/services/chat_service.dart';
import 'package:iti_cu/core/services/firebase_auth_service.dart';
import 'package:iti_cu/core/services/firebase_user_status.dart';
import 'package:iti_cu/core/services/user_manager.dart';

class PrivateChatScreen extends StatefulWidget {
  final AppUser otherUser;
  const PrivateChatScreen({super.key, required this.otherUser});
  @override
  State<PrivateChatScreen> createState() => _PrivateChatScreenState();
}

class _PrivateChatScreenState extends State<PrivateChatScreen> {
  final TextEditingController _msg = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final String currentUid = FirebaseAuthService.getCurrentUser()!.uid;
  final UserManager _userManager = UserManager();
  late String chatId;

  @override
  void initState() {
    super.initState();
    chatId = ChatService.getChatId(currentUid, widget.otherUser.uid);
    _msg.addListener(
      () => _userManager.setTyping(currentUid, _msg.text.isNotEmpty),
    );
  }

  @override
  void dispose() {
    _msg.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _sendText() async {
    final text = _msg.text.trim();
    if (text.isEmpty) return;
    _msg.clear();
    await ChatService.sendTextMessage(
      chatId: chatId,
      senderUid: currentUid,
      senderName: 'Me',
      receiverUid: widget.otherUser.uid,
      text: text,
    );
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scroll.hasClients) _scroll.jumpTo(_scroll.position.maxScrollExtent);
  }

  Widget _buildMsg(Map<String, dynamic> data) {
    final isMe = data['senderUid'] == currentUid;
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? AppColors.cyan : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          data['content'] ?? '',
          style: TextStyle(color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.otherUser.name),
            StreamBuilder<DatabaseEvent>(
              stream: FirebaseUserStatus.getStatus(widget.otherUser.uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data?.snapshot.value == null)
                  return const Text('Offline', style: TextStyle(fontSize: 12));
                final map = Map<String, dynamic>.from(
                  snapshot.data!.snapshot.value as Map,
                );
                if (map['typing'] == true)
                  return const Text(
                    'typing...',
                    style: TextStyle(color: AppColors.cyan, fontSize: 12),
                  );
                return Text(
                  map['online'] == true ? 'Online' : 'Offline',
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ChatService.getMessages(chatId),
              builder: (context, snap) {
                if (!snap.hasData)
                  return const Center(child: CircularProgressIndicator());
                final msgs = snap.data!.docs;
                return ListView.builder(
                  controller: _scroll,
                  itemCount: msgs.length,
                  itemBuilder: (ctx, i) =>
                      _buildMsg(msgs[i].data() as Map<String, dynamic>),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.primary,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msg,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Message...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.cyan),
                  onPressed: _sendText,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
