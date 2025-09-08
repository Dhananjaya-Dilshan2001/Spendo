import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spendo/firebase_options.dart';
import 'package:spendo/screen/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
