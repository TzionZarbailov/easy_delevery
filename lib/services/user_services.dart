import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/user.dart';

class UserServices {
  // get collection of users
  final CollectionReference _user =
      FirebaseFirestore.instance.collection('users');

  // CREATE: add a new user and doc is email
  Future<void> addUser(User user) async {
    await _user.doc(user.email.trim()).set(user.toMap());
  }

  //
  Stream<Map<String, dynamic>> getUser(String email) {
    return _user.doc(email).snapshots().map((snapshot) {
      return snapshot.data() as Map<String, dynamic>;
    });
  }

  Stream<QuerySnapshot> getRestaurantName() {
    final userStream =
        _user.orderBy('businessName', descending: true).snapshots();

    return userStream;
  }

  // READ: Get a user role User by email and return a map
  Stream<QuerySnapshot> getUserRole() {
    final userStream = _user.orderBy('role', descending: true).snapshots();

    return userStream;
  }

  // UPDATE: update a user by email
  Future<void> updateBusinessOwner(
      String email, Map<String, dynamic> newdata) async {
    await _user.doc(email).update(newdata);
  }
}
