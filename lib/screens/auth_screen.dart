import 'package:easy_delevery/screens/login_screen.dart';
import 'package:easy_delevery/screens/registration_screen.dart';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
// intially, show the login screen
  bool _showLoginScreen = true;

  void toggleScreens() {
    setState(() {
      _showLoginScreen = !_showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showLoginScreen) {
      return LoginScreen(showRegisterPage: toggleScreens);
    } else {
      return RegistrationScreen(showLoginPage: toggleScreens);
    }
  }
}
