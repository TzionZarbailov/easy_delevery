import 'package:easy_delevery/services/user_repository.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();

    return Scaffold(
      body: userRepository.getStreamBuilder(),
    );
  }
}
