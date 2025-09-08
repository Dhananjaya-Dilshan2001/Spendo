import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, User;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendo/core/model/user.dart';
import 'package:spendo/core/repository/firebase.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/popUpDialog.dart';

class LoggingPage extends StatefulWidget {
  const LoggingPage({super.key});

  @override
  State<LoggingPage> createState() => _LoggingPageState();
}

class _LoggingPageState extends State<LoggingPage> {
  FirebaseRepository firebase = FirebaseRepository();
  @override
  void initState() {
    cheackIsUserSignIn();
    super.initState();
  }

  void cheackIsUserSignIn() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (!mounted) return;
      if (user == null) {
        print('User is currently signed out!');
        showSimpleSnackbar(context, 'User is currently signed out!');
        //Navigator.pushReplacementNamed(context, '/logging');
      } else {
        print('User is signed in!');
        firebase.getUserByID(user.uid).then((appUser) {
          if (appUser != null) {
            showSimpleSnackbar(context, 'User Logging in!');
            Navigator.pushReplacementNamed(
              context,
              '/home',
              arguments: user.uid,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SignInScreen(
        headerMaxExtent: MediaQuery.of(context).size.height * 0.25,
        showAuthActionSwitch: true,
        showPasswordVisibilityToggle: true,
        providers: [EmailAuthProvider()],
        headerBuilder: (context, constraints, _) {
          return Container(
            //color: Colors.white,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Image.asset('assets/Images/logo.png'),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Welcome to Spendo',
                  style: TextStyle(
                    color: AppColors.color1,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
        styles: const {
          EmailFormStyle(signInButtonVariant: ButtonVariant.filled),
        },
        actions: [
          AuthStateChangeAction<SignedIn>((context, state) {
            createNewUserAccountController(state, context);
          }),
          AuthStateChangeAction<UserCreated>((context, state) {
            if (state.credential.user != null) {
              showSimpleSnackbar(context, 'User Registered Successfully');
              Navigator.pushReplacementNamed(context, '/logging');
            }
          }),
        ],
      ),
    );
  }

  void createNewUserAccountController(SignedIn state, BuildContext context) {
    if (state.user != null) {
      state.user!.reload();
      firebase.isUserExist(state.user!.uid).then((exists) {
        if (exists) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          var name = showDialog(
            context: context,
            builder: (context) {
              return SimpleUserInput(
                title: 'Name',
                hintText: 'Enter your name',
                variableName: 'name',
              );
            },
          );
          name.then((value) {
            if (value != null && value.isNotEmpty) {
              firebase
                  .addUser(
                    AppUser(
                      id: state.user!.uid,
                      name: value,
                      email: state.user!.email ?? '',
                      monthlyBudget: 0,
                      monthlyExpectedIncome: 0,
                      monthlyExpectedOutcome: 0,
                    ),
                  )
                  .then((_) {
                    showSimpleSnackbar(context, 'User Registered Successfully');
                    Navigator.pushReplacementNamed(
                      context,
                      '/home',
                      arguments: state.user!.uid,
                    );
                  });
            } else {
              showSimpleSnackbar(
                context,
                'Name cannot be empty. Please register again.',
              );
            }
          });
          showSimpleSnackbar(context, 'User does not exist, Please Register');
        }
      });
    } else {
      showSimpleSnackbar(context, 'Please Register to continue');
    }
  }
}
