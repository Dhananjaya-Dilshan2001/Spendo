import 'package:flutter/material.dart';
import 'package:spendo/screen/home_page.dart';
import 'package:spendo/screen/logging_page.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute:
          (settings) => MaterialPageRoute(
            builder: (context) {
              switch (settings.name) {
                case '/':
                  return const HomePage();
                case '/home':
                  return const LoggingPage();
                default:
                  return const LoggingPage();
              }
            },
          ),
    );
  }
}
