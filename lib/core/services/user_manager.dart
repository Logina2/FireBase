import 'package:firebase_database/firebase_database.dart';
import 'package:iti_cu/core/services/firebase_user_status.dart';

class UserManager {
  final _connectRef = FirebaseUserStatus.connectionStatus;
  final _userRef = FirebaseUserStatus.userStatus;

  void init(String userId) {
    _connectRef.onValue.listen((event) {
      final connect = event.snapshot.value as bool? ?? false;
      if (!connect) return;

      _userRef.child("status").child(userId).onDisconnect().update({
        "online": false,
        "last_seen": ServerValue.timestamp,
      });

      _userRef.child("status").child(userId).update({
        "online": true,
        "last_seen": ServerValue.timestamp,
      });
    });
  }

  Future<void> setTyping(String userId, bool typing) async {
    await _userRef.child("status").child(userId).update({"typing": typing});
  }
}
