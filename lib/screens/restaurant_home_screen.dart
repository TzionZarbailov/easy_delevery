import 'package:easy_delevery/colors/my_colors.dart';
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
    user.getBusinessOwnerr();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: myColors.inputColor,
        child: Column(
          children: [
            const DrawerHeader(
              child: Row(
                children: [
                  Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'תפריט',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text(
                'התנתקות',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
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
              color: Colors.white,

            ),
            backgroundColor: Colors.black,
            title: FutureBuilder(
              future: user.getBusinessOwnerr(),
              builder: (context, snapshot) {
                return getNameRestaurant();
              },
            ),
            centerTitle: true,
            
          ),
        ],
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('BusinessOwner signed in as: '),
              ElevatedButton(
                onPressed: () async {
                  await user.signOut();
                },
                child: const Text('Sign out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
