import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:iti_cu/core/common_model/app_user.dart';

class FirebaseFirestoreService {
  FirebaseFirestoreService._();
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> saveUserData(AppUser user) async {
    await _db.collection("users").doc(user.uid).set(user.toMap());
  }

  static Future<AppUser> getUserData(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return AppUser.fromMap(doc.data() as Map<String, dynamic>);
  }

  static Future<List<AppUser>> getAllUsers(String currentUid) async {
    final snapshot = await _db.collection("users").get();
    return snapshot.docs
        .map((doc) => AppUser.fromMap(doc.data()))
        .where((user) => user.uid != currentUid)
        .toList();
  }
}
