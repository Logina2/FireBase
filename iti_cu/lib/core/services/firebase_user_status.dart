import 'package:firebase_database/firebase_database.dart';

class FirebaseUserStatus {
  FirebaseUserStatus._();
  static final userStatus = FirebaseDatabase.instance.ref();
  static final connectionStatus = FirebaseDatabase.instance.ref(
    ".info/connected",
  );

  static Stream<DatabaseEvent> getStatus(String userId) {
    return userStatus.child("status").child(userId).onValue;
  }
}
