import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:easy_delevery/services/get_firestore/get_restaurant_name.dart';
import 'package:easy_delevery/services/user_repository.dart';
import 'package:flutter/material.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({super.key, this.businessOwner});
  final BusinessOwner? businessOwner;

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreen();
}

class _RestaurantHomeScreen extends State<RestaurantHomeScreen> {
  final user = UserRepository();

  List<String> docID = UserRepository.docBusinessOwners;

  // get restaurant name
  getNameRestaurant() {
    for (int i = 0; i < docID.length; i++) {
      if (docID[i] == user.getUserEmail) {
        return GetRestaurantName(documentId: docID[i]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    user.getUser();
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
                    backgroundImage: AssetImage(''),
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder(
                    future: user.getUser(),
                    builder: (context, snapshot) {
                      return getNameRestaurant();
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              trailing: const Text(
                'דף הבית',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              trailing: const Text(
                'היסטורית הזמנות',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              trailing: const Text(
                'אזור אישי',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              trailing: const Text(
                'התנתקות',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
              ),
              onTap: () async {
                await user.signOut();
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            iconTheme: const IconThemeData(
              color: myColors.buttonColor,
            ),
            backgroundColor: Colors.black,
            title: FutureBuilder(
              future: user.getUser(),
              builder: (context, snapshot) {
                return getNameRestaurant();
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
