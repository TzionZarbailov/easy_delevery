import 'package:easy_delevery/screens/auth_screen.dart';
import 'package:easy_delevery/screens/consumer_home_screen.dart';
import 'package:easy_delevery/screens/restaurant_home_screen.dart';
import 'package:easy_delevery/services/user_repository.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();

    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return userRepository.getStreamBuilder();
          } else {
            return const AuthScreen();
          }
        },
      ),
    );
  }
}
