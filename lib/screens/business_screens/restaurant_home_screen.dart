// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:easy_delevery/screens/business_screens/order_history.dart';
import 'package:easy_delevery/screens/business_screens/edit_menu.dart';
import 'package:easy_delevery/services/restaurant_services.dart';
import 'package:flutter/material.dart';

import 'package:easy_delevery/services/get_firestore/get_restaurant_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_delevery/services/auth_services.dart';

import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_button.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({
    super.key,
  });

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreen();
}

class _RestaurantHomeScreen extends State<RestaurantHomeScreen> {
  final userAuth = FirebaseAuth.instance.currentUser!;

  List<String> docID = [];

  getRestaurantName() {
    for (var i = 0; i < docID.length; i++) {
      if (docID[i].isNotEmpty) {
        return GetRestaurantName(documentId: docID[i]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        backgroundColor: myColors.inputColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(
                        'https://imageproxy.wolt.com/menu/menu-images/5e31b8bffc976d04113c03ee/e8a24902-3140-11ed-ac42-fece14553f35____________.jpeg'),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: RestaurantServices().getDocId(docID),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(
                          color: Colors.orange[400],
                        ); // Loading indicator while waiting
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Display error
                      } else {
                        return getRestaurantName(); // Use snapshot data
                      }
                    },
                  )
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text(
                'דף הבית',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text(
                'היסטורית הזמנות',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const OrderHistory();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'עריכת תפריט',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const EditMenu();
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'התנתקות',
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              onTap: () async {
                await AuthServices.signOut();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: myColors.buttonColor,
                height: 2,
              ),
            ),
            iconTheme: const IconThemeData(
              color: myColors.buttonColor,
            ),
            backgroundColor: Colors.black,
            title: FutureBuilder(
              future: RestaurantServices().getDocId(docID),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    color: Colors.orange[400],
                  ); // Loading indicator while waiting
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Display error
                } else {
                  return getRestaurantName(); // Use snapshot data
                }
              },
            ),
            centerTitle: true,
          ),
        ],
        body: Column(
          children: [
            const Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      text: 'פתיחת מסעדה',
                      horizontal: 10,
                      vertical: 10,
                      fontSize: 15,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
