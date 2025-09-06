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
          if (!state.user!.emailVerified) {
            Navigator.pushNamed(context, '/home');
          } else {
            Navigator.pushReplacementNamed(context, '/home');
          }
        }),
        // AuthStateChangeAction<SignedIn>((context, state) {
        //   Navigator.pushReplacementNamed(context, '/home');
        // }),
        // AuthStateChangeAction<UserCreated>((context, state) {
        //   print('User Created: ${state.credential.user?.email}');
        //   Navigator.pushReplacementNamed(context, '/home');
        // }),
      ],
    );
  }
}
