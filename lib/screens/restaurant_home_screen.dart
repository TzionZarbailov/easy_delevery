
import 'package:easy_delevery/models/user.dart';
import 'package:flutter/material.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key, this.user});
  final BusinessOwner? user;

  @override
  State<RestaurantHomeScreen> createState() =>
      _RestaurantHomeScreen();
}

class _RestaurantHomeScreen extends State<RestaurantHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.greenAccent,
    );
  }
}
