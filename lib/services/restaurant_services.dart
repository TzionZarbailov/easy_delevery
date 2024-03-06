// ignore_for_file: unrelated_type_equality_checks, avoid_function_literals_in_foreach_calls, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class RestaurantServices {
  // get collection of restaurants
  final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');
  final AuthServices _auth = AuthServices();

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
    await restaurants.doc(_auth.getUid).set(restaurant.toMap());
  }

  // get all categories of a restaurant
  Stream<QuerySnapshot> getCategories() {
    final categories =
        restaurants.orderBy('categories', descending: true).snapshots();
    return categories;
  }

  // get all categories of a restaurant
  Stream<QuerySnapshot> getCategoriesByDocId(String docID) {
    final categories =
        restaurants.doc(docID).collection('categories').snapshots();
    return categories;
  }

  // UPDATE: update a restaurant
  Future<void> updateRestaurant(String id, Map<String, dynamic> newdata) async {
    await restaurants.doc(id).update(newdata);
  }

  // DELETE: delete categories in a restaurant
  Future<void> deleteCategory(
      String docID, Map<String, dynamic> categoryToRemove) {
    return restaurants.doc(docID).update({
      'categories': FieldValue.arrayRemove([categoryToRemove])
    });
  }

  // update menu item in a restaurant by doc id
  Future<void> updateMenuItem(
      String docId, Map<String, dynamic> updatedData) async {
    try {
      final menuItemsCollection =
          FirebaseFirestore.instance.collection('menuItems');
      await menuItemsCollection.doc(docId).update(updatedData);
      print('ה-MenuItem עודכן בהצלחה!');
    } catch (e) {
      print('שגיאה בעדכון ה-MenuItem: $e');
    }
  }

  Future<void> uploadImageUint(String docId, Uint8List image) async {
    final docRef =
        FirebaseFirestore.instance.collection('restaurants').doc(docId);
    docRef.get().then((document) async {
      if (document.exists) {
        await docRef.update({
          'restaurantImage': image,
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  Future<void> uploadImageFile(String docId, File imageFile) async {
    final docRef =
        FirebaseFirestore.instance.collection('restaurants').doc(docId);
    docRef.get().then((document) async {
      if (document.exists) {
        Uint8List image = await imageFile.readAsBytes();
        await docRef.update({
          'restaurantImage': image, // Use 'restaurantImage' as the key
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
