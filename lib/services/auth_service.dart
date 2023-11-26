import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // instance of firestore
  final FirebaseAuth _auth = FirebaseAuth.instance; // instance of firebase auth
  final CollectionReference _consumersCollectionReference = FirebaseFirestore.instance.collection('consumers'); // instance of consumers collection
  final CollectionReference _businessOwnerCollectionReference = FirebaseFirestore.instance.collection('businessOwner'); // instance of business owner collection
  Future<void> saveConsumer(Consumer consumer) async {
    try {
      await _firestore
          .collection('consumers')
          .doc(consumer.id)
          .set(consumer.toMap());
      await _auth.createUserWithEmailAndPassword(
          email: consumer.email, password: consumer.password);
    } catch (e) {
      Text('Error saving consumer: $e');
    }
  }

  Future<void> saveBusinessOwner(BusinessOwner businessOwner) async {
    try {
      await _firestore
          .collection('business_owners')
          .doc(businessOwner.id)
          .set(businessOwner.toMap());
      await _auth.createUserWithEmailAndPassword(
          email: businessOwner.email, password: businessOwner.password);
    } catch (e) {
      Text(
        'Error saving business owner: $e',
        style: const TextStyle(color: myColors.errorColor),
      );
    }
  }
  
}
