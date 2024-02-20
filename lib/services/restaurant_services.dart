// ignore_for_file: unrelated_type_equality_checks, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RestaurantServices {
  // get collection of restaurants
  static final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  final userAuth = FirebaseAuth.instance.currentUser!;

  // get all restaurants

  Future getAllRestaurants(List restaurantList) async {
    try {
      restaurants.get().then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          restaurantList.add(doc.data());
        });
      });
      return restaurantList;
    } catch (e) {
      rethrow;
    }
  }

  // get restaurant by id with a users collection by restaurantId
  Future getRestaurantById(String id) async {
    try {
      await restaurants.doc(id).get().then((doc) {
        return doc.data();
      });
    } catch (e) {
      rethrow;
    }
  }

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
              // ignore: avoid_print
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

              // ignore: avoid_print
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

  static Future<void> addRestaurantAutoId(Restaurant restaurant) async {
    await restaurants.add(restaurant.toMap());
  }

  // READ: Get a restaurant by id and return a QuerySnapshot
  static Stream<QuerySnapshot> getRestaurant() {
    final restaurantStream =
        restaurants.orderBy('id', descending: true).snapshots();

    return restaurantStream;
  }

  // UPDATE: update a restaurant
  Future<void> updateRestaurant(String id, Map<String, dynamic> newdata) async {
    await restaurants.doc(id).update(newdata);
  }
}
