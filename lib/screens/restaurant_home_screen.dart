import 'package:easy_delevery/models/user.dart';
import 'package:easy_delevery/services/user_repository.dart';
import 'package:flutter/material.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key, this.user});
  final BusinessOwner? user;

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreen();
}

class _RestaurantHomeScreen extends State<RestaurantHomeScreen> {
  final user = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: prefer_interpolation_to_compose_strings
            Text('BusinessOwner signed in as: ' + user.getUserEmail),
            ElevatedButton(
              onPressed: () async {
                await user.signOut();
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
