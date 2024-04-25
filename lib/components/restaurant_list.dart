// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:easy_delevery/screens/consumer_screens/restaurant_details.dart';
import 'package:easy_delevery/services/restaurant_services.dart';

import 'package:flutter/material.dart';

class RestaurantList extends StatelessWidget {
  final String? restaurantType;
  final String? searchText;

  const RestaurantList({
    super.key,
    this.restaurantType,
    this.searchText,
  });

  void _openRestaurantDetails(BuildContext context, String restaurantId) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return RestaurantDetails(
            restaurantId: restaurantId,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: searchText != null
          ? RestaurantServices().getRestaurantsByName(searchText!)
          : RestaurantServices().getRestaurantsByType(restaurantType!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              color: myColors.buttonColor,
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.data!.docs.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 5),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange[400],
                ),
              ),
            );
          }
          final restaurants = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Restaurant(
              id: data['id'] ?? '',
              name: data['name'] ?? '',
              address: data['address'] ?? '',
              phoneNumber: data['phoneNumber'] ?? '',
              isOpen: data['isOpen'],
              restaurantImage: data['restaurantImage'] ?? '',
            );
          }).toList();

          if (restaurants.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: Text(
                  '.אין מסעדות זמינות כעת',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          }

          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.9,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                // Sort the restaurants list based on the isOpen property
                final sortedRestaurants = [...restaurants]..sort((a, b) =>
                    ((b.isOpen ?? false) ? 1 : 0) -
                    ((a.isOpen ?? false) ? 1 : 0));
                final restaurant = sortedRestaurants[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  clipBehavior: Clip.hardEdge,
                  elevation: 2,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          _openRestaurantDetails(
                              context, snapshot.data!.docs[index].id);
                          print(
                              'Restaurant ID: ${snapshot.data!.docs[index].id}');
                        },
                        splashColor: myColors.buttonColor.withOpacity(0.5),
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                image: restaurant.restaurantImage != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            restaurant.restaurantImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 3,
                                      horizontal: 25,
                                    ),
                                    width: 375,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          myColors.buttonColor.withOpacity(0.8),
                                          Colors.white.withOpacity(0.4),
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${restaurant.name} | ${restaurant.address}',
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!(restaurant.isOpen ?? false))
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(0, 56, 55, 55)
                                  .withOpacity(0.7),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Center(
                              child: Text(
                                'סגור כעת',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink(); // Add this line to handle null snapshot
      },
    );
  }
}
