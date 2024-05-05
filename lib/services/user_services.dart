// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print, unrelated_type_equality_checks

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:easy_delevery/services/auth_services.dart';

class UserServices {
  // get collection of users
  static final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');

  //* CREATE: add a new user and doc is email
  Future<void> addUser(User user) async {
    await _user.doc(AuthServices.getUid).set(user.toMap());
  }

  // Get: get a consumer by doc id order by phone number
  static Future getUser(String uid, String getName) async {
    DocumentSnapshot doc = await _user.doc(uid).get();

    return doc[getName];
  }

  // UPDATE: update a user by email
  Future<void> updateBusinessOwner(
      String email, Map<String, dynamic> newdata) async {
    await _user.doc(email).update(newdata);
  }

  // update user by uid
  static Future<void> updateUser(
      String uid, Map<String, dynamic> newdata) async {
    await _user.doc(uid).update(newdata);
  }
}
