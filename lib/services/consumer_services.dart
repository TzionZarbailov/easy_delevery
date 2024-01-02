import 'package:cloud_firestore/cloud_firestore.dart';

class ConsumerServices {
  // get collection of users
  final CollectionReference _consumer =
      FirebaseFirestore.instance.collection('users');

  // CREATE: add a new user and doc is email
  Future<void> addConsumer(String email, Map<String, dynamic> data) async {
    await _consumer.doc(email).set(data);
  }
}
