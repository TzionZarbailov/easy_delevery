import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/screens/consumer_screens/consumer_home.dart';

import 'package:easy_delevery/screens/consumer_screens/profile.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  final List<Widget> _pages = [
    const ConsumerHome(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.7),
              myColors.buttonColor.withOpacity(0.5),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.transparent,
          selectedIndex: _currentPageIndex,
          onDestinationSelected: (index) {
            _onPageChanged(index);
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: Colors.white,
          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: Colors.black,
                size: 30,
              ),
              label: 'דף הבית',
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person,
                color: Colors.black,
                size: 30,
              ),
              label: 'אזור אישי',
            ),
          ],
        ),
      ),
    );
  }
}
