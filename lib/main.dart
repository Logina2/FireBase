import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:iti_cu/app/my_app.dart';
import 'package:iti_cu/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!kIsWeb) {
    FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://chatapp-2fcb9-default-rtdb.firebaseio.com',
    ).setPersistenceEnabled(true);
  }

  runApp(const MyApp());
}
