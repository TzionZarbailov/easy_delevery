
import 'package:easy_delevery/models/user.dart';
import 'package:flutter/material.dart';

class BusinessOwnerHomeScreen extends StatefulWidget {
  const BusinessOwnerHomeScreen({super.key, this.user});
  final BusinessOwner? user;

  @override
  State<BusinessOwnerHomeScreen> createState() =>
      _BusinessOwnerHomeScreenState();
}

class _BusinessOwnerHomeScreenState extends State<BusinessOwnerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.greenAccent,
    );
  }
}
