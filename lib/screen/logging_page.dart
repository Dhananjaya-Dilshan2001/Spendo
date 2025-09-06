import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class LoggingPage extends StatefulWidget {
  const LoggingPage({super.key});

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SignInScreen(providers: [EmailAuthProvider()]));
  }
}
