import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class LoggingPage extends StatefulWidget {
  const LoggingPage({super.key});

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        //Navigator.pushReplacementNamed(context, '/logging');
      } else {
        print('User is signed in!');
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      headerMaxExtent: 200,
      providers: [EmailAuthProvider()],

      headerBuilder: (context, constraints, _) {
        return Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Image.asset('assets/Images/Logo with name.png'),
        );
      },

      styles: const {EmailFormStyle(signInButtonVariant: ButtonVariant.filled)},
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          print(state.user);
          // Navigate to home page after sign in
          if (!state.user!.emailVerified) {
            Navigator.pushNamed(context, '/home');
          } else {
            Navigator.pushReplacementNamed(context, '/home');
          }
        }),
      ],
    );
  }
}
