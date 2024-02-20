// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:easy_delevery/services/auth_services.dart';

class UserServices {
  // get collection of users
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');

  // CREATE: add a new user and doc is email
  // Future<void> addUser(User user) async {
  //   await _user.doc(user.email.trim()).set(user.toMap());
  // }

  // CREATE: add a new user and autmatically generate doc id
  Future<void> addUserAutoId(User user) async {
    await _user.add(user.toMap());
  }

  static Future<String> getBusinessNameByDocId(String docId) async {
    // Get a DocumentReference for the document with the specified ID
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('businessName').doc(docId);

    // Get a DocumentSnapshot for the document
    DocumentSnapshot docSnapshot = await docRef.get();

    // If the document exists, return the restaurant name
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      String? userEmail = AuthServices.getEmail;
      if (data != null && data['email'] == userEmail) {
        return data['businessName'];
      }
    }

    // If the document doesn't exist, or it doesn't have a 'name' field, return null
    return '';
  }

  // Get: get a user
  Future getUser() async {
    List docId = [];
    await _user.get().then(
          (value) => value.docs.forEach(
            (document) {
              print(document.reference);
              docId.add(document.id);
            },
          ),
        );
    return docId;
  }

  // UPDATE: update a user by email
  Future<void> updateBusinessOwner(
      String email, Map<String, dynamic> newdata) async {
    await _user.doc(email).update(newdata);
  }
}
