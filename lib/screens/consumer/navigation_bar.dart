import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/screens/consumer/home_page.dart';
import 'package:easy_delevery/screens/consumer/profile.dart';
import 'package:easy_delevery/screens/consumer/shopping_cart.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int _currentPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const ShoppingCart(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: NavigationBar(),
    );
  }
}
