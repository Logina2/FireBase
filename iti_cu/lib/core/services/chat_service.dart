import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, voice }

class ChatService {
  ChatService._();
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static String getChatId(String uid1, String uid2) {
    final ids = [uid1, uid2]..sort();
    return '${ids[0]}_${ids[1]}';
  }

  static Future<void> sendTextMessage({
    required String chatId,
    required String senderUid,
    required String senderName,
    required String receiverUid,
    required String text,
  }) async {
    await _save(
      chatId: chatId,
      senderUid: senderUid,
      senderName: senderName,
      receiverUid: receiverUid,
      type: MessageType.text,
      content: text,
      preview: text,
    );
  }

  static Future<void> sendImageMessage({
    required String chatId,
    required String senderUid,
    required String senderName,
    required String receiverUid,
    required File imageFile,
  }) async {
    final base64 = base64Encode(await imageFile.readAsBytes());
    await _save(
      chatId: chatId,
      senderUid: senderUid,
      senderName: senderName,
      receiverUid: receiverUid,
      type: MessageType.image,
      content: base64,
      preview: '📷 Photo',
    );
  }

  static Future<void> sendVoiceMessage({
    required String chatId,
    required String senderUid,
    required String senderName,
    required String receiverUid,
    required File voiceFile,
    required int durationSeconds,
  }) async {
    final base64 = base64Encode(await voiceFile.readAsBytes());
    await _save(
      chatId: chatId,
      senderUid: senderUid,
      senderName: senderName,
      receiverUid: receiverUid,
      type: MessageType.voice,
      content: base64,
      preview: '🎤 Voice message',
      durationSeconds: durationSeconds,
    );
  }

  static Future<void> _save({
    required String chatId,
    required String senderUid,
    required String senderName,
    required String receiverUid,
    required MessageType type,
    required String content,
    required String preview,
    int? durationSeconds,
  }) async {
    final ts = FieldValue.serverTimestamp();
    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
          'type': type.name,
          'content': content,
          'senderUid': senderUid,
          'senderName': senderName,
          'timestamp': ts,
          if (durationSeconds != null) 'duration': durationSeconds,
        });
    await _firestore.collection('chats').doc(chatId).set({
      'lastMessage': preview,
      'lastMessageTime': ts,
      'participants': [senderUid, receiverUid],
    }, SetOptions(merge: true));
  }

  static Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
