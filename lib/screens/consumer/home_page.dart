import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/restaurant_list.dart';
import 'package:easy_delevery/screens/consumer/profile.dart';
import 'package:easy_delevery/screens/consumer/shopping_cart.dart';
import 'package:flutter/material.dart';

import 'package:easy_delevery/components/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  final List<Widget> pages = [
    const HomeScreen(),
    const ShoppingCart(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          selectedIndex: currentPageIndex,
          onDestinationSelected: (index) {
            _onPageChanged(index);
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              selectedIcon: Icon(Icons.home),
              label: 'דף הבית',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart),
              selectedIcon: Icon(Icons.shopping_cart),
              label: 'עגלה',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              selectedIcon: Icon(Icons.person),
              label: 'פרופיל',
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '?אז מה תרצו להזמין',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'חיפוש'),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      child: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'קטגוריות',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              //* Categories list view
              const Categories(),

              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'פופולרי',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              //* list view Restaurants
              const RestaurantList(onTap: null),

              // SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              // ElevatedButton(
              //   onPressed: () async {
              //     await AuthServices().signOut();
              //   },
              //   child: const Text('התנתקות'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
