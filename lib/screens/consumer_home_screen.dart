import 'package:flutter/material.dart';

import 'package:easy_delevery/services/user_repository.dart';

class ConsumerHomeScreen extends StatefulWidget {
  const ConsumerHomeScreen({Key? key}) : super(key: key);

  @override
  State<ConsumerHomeScreen> createState() => _ConsumerHomeScreenState();
}

class _ConsumerHomeScreenState extends State<ConsumerHomeScreen> {
  final user = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amberAccent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: prefer_interpolation_to_compose_strings
              Text('Consumer signed in as: ' + user.getUserEmail),
              ElevatedButton(
                onPressed: () async {
                  await user.signOut();
                },
                child: const Text('Sign out'),
              ),
            ],
          ),
        ));
  }
}
