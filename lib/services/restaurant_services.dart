// ignore_for_file: unrelated_type_equality_checks, avoid_function_literals_in_foreach_calls, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RestaurantServices {
  // get collection of restaurants
  static final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  final userAuth = FirebaseAuth.instance.currentUser!;

  Future getDocId(List<String> docID) async {
    String restaurantId = '';

    await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userAuth.email)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              restaurantId = document['restaurantId'];

              print(
                  'The business number of the business owner is: $restaurantId');
            },
          ),
        );

    await FirebaseFirestore.instance
        .collection('restaurants')
        .where('id', isEqualTo: restaurantId)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              docID.add(document.reference.id);

              print('Is the doc of the restaurant: ${document.reference.id}');
            },
          ),
        );
    for (var i = 0; i < docID.length; i++) {
      if (docID[i].isNotEmpty) {
        return docID[i];
      }
    }
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    await restaurants.doc(AuthServices.getUid).set(restaurant.toMap());
  }

  // get all restaurants to the list
  // Stream<QuerySnapshot> getAllRestaurants() {
  //   final restaurants =
  //       FirebaseFirestore.instance.collection('restaurants').snapshots();
  //   return restaurants;
  // }

  // get resaurant by click on the restaurant
  // Future<Restaurant> getRestaurant(String docID) async {
  //   final docSnapshot = await restaurants.doc(docID).get();

  //   if (docSnapshot.exists) {
  //     final data = docSnapshot.data()!;
  //     return Restaurant.fromMap(
  //         Map<String, dynamic>.from(data as Map<String, dynamic>));
  //   } else {
  //     throw Exception('Restaurant not found');
  //   }
  // }

  static Future getRestaurantName(String uid, String getName) async {
    DocumentSnapshot doc = await restaurants.doc(uid).get();

    return doc[getName];
  }

  Future<Restaurant> getRestaurantById(String id) async {
    // Fetch the restaurant data from your data source using the provided id
    // For example, if you're using Firestore, you might do something like this:
    var doc = await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(id)
        .get();

    // Then, convert the fetched data into a Restaurant object and return it
    // This will depend on how your Restaurant class is defined
    var restaurant = Restaurant.fromDocument(doc);

    return restaurant;
  }

  // get all categories of a restaurant
  Stream<QuerySnapshot> getCategories() {
    final categories =
        restaurants.orderBy('categories', descending: true).snapshots();
    return categories;
  }

  // // get all categories of a restaurant
  // Stream<QuerySnapshot> getCategoriesByDocId(String docID) {
  //   final categories =
  //       restaurants.doc(docID).collection('categories').snapshots();
  //   return categories;
  // }

  // get all menu items of a restaurant
  Stream<QuerySnapshot> getMenuItems() {
    final menuItems =
        restaurants.orderBy('menuItems', descending: true).snapshots();
    return menuItems;
  }

  // UPDATE: update restaurant data
  Future<void> updateRestaurantData(
      String docID, Map<String, dynamic> restaurantData) {
    return restaurants.doc(docID).update(restaurantData);
  }

  //* is open restaurant?
  updateIsOpen(String docID, bool isOpen) {
    return restaurants.doc(docID).update({'isOpen': isOpen});
  }

  // GET: get all restaurants by restaurantType
  Stream<QuerySnapshot> getRestaurantsByType(String restaurantType) {
    if (restaurantType == 'הכל') {
      return restaurants.snapshots();
    } else {
      return restaurants
          .where('restaurantType', isEqualTo: restaurantType)
          .snapshots();
    }
  }

  //GET: get restaurant by name for search bar
  Stream<QuerySnapshot> getRestaurantsByName(String restaurantName) {
    //* //The '\uf8ff' is a very high Unicode value which will select all strings that start with restaurantName.
    return restaurants
        .orderBy('name')
        .startAt([restaurantName]).endAt(['$restaurantName\uf8ff']).snapshots();
  }

  // DELETE: delete categories in a restaurant
  Future<void> deleteCategory(
      String docID, Map<String, dynamic> categoryToRemove) {
    return restaurants.doc(docID).update({
      'categories': FieldValue.arrayRemove([categoryToRemove])
    });
  }

  Future<void> deleteMenuItem(
      String docID, Map<String, dynamic> menuItemToRemove) {
    return restaurants.doc(docID).update({
      'menuItems': FieldValue.arrayRemove([menuItemToRemove])
    });
  }
}
