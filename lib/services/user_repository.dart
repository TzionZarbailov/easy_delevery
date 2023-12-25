import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: library_prefixes
import 'package:easy_delevery/models/user.dart' as EasyDeliveryUser;
import 'package:easy_delevery/screens/auth_screen.dart';
import 'package:easy_delevery/screens/consumer_home_screen.dart';
import 'package:easy_delevery/screens/restaurant_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  static final List<String> docBusinessOwners = [];

  signInWithGoogle() async {
    //* begin interactive sign-in process
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //* obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //* create a new credential user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //* finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // add business owner to firestore
  Future addBusinessOwner(EasyDeliveryUser.BusinessOwner businessOwner) async {
    await collection.doc(businessOwner.email.trim()).set(businessOwner.toMap());
  }

  // add consumer to firestore
  Future addConsumer(EasyDeliveryUser.Consumer consumer) async {
    await collection.doc(consumer.email).set(consumer.toMap());
  }

  Future getUser() async {
    await _firestore.collection('users').get().then(
          // ignore: avoid_function_literals_in_foreach_calls
          (snapshot) => snapshot.docs.forEach(
            (document) {
              // ignore: avoid_print
              print(document.reference);
              docBusinessOwners.add(document.reference.id);
            },
          ),
        );
  }

  

  // rea*d business owner from firestore
  Future<EasyDeliveryUser.BusinessOwner> readBusinessOwner(String email,
      {required businessName}) async {
    final businessOwner = await collection.doc(email).get();
    return EasyDeliveryUser.BusinessOwner.fromMap(
        businessOwner.data()! as Map<String, dynamic>);
  }

  //* read consumer from firestore
  Future<EasyDeliveryUser.Consumer> readConsumer(String email) async {
    final consumer = await collection.doc(email).get();
    return EasyDeliveryUser.Consumer.fromMap(
        consumer.data()! as Map<String, dynamic>);
  }

  // sign in with email and password
  Future<UserCredential> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Check if the userCredential is null or has an empty user UID
      if (userCredential.toString().isEmpty ||
          userCredential.user?.uid == null) {
        throw Exception('Invalid email or password');
      }
      return userCredential;
    } catch (e) {
      throw Exception('Invalid email or password');
    }
  }

  //! Bring me a stream that checks in firestore collection if it is a consumer or a business owner
  Stream<DocumentReference> getRoleStream(String email) {
    return _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .snapshots()
        .map((event) => event.docs.first.reference);
  }

  //! register BusinessOwner
  Future registerBusinessOwner(
      EasyDeliveryUser.BusinessOwner businessOwner) async {
    // create user in auth by email and password
    await _auth.createUserWithEmailAndPassword(
      email: businessOwner.email.trim(),
      password: businessOwner.password.trim(),
    );

    // create BusinessOwner in firestore
    await addBusinessOwner(businessOwner);

    // Clearing app data
    await _auth.setPersistence(Persistence.NONE);
  }

  //! register Consumer
  Future registerConsumer(EasyDeliveryUser.Consumer consumer) async {
    // create user in auth
    await _auth.createUserWithEmailAndPassword(
      email: consumer.email.trim(),
      password: consumer.password.trim(),
    );

    // create Consumer in firestore
    await addConsumer(consumer);

    // Clearing app data
    await _auth.setPersistence(Persistence.NONE);
  }

  // get email from uuid in auth
  String get getUserEmail {
    return _auth.currentUser!.email!;
  }

  // get user phone number
  String get getUserPhoneNumber {
    return _auth.currentUser!.phoneNumber!;
  }

  // get user uid
  String get getUserUid {
    return _auth.currentUser!.uid;
  }

  // password reset with email
  Future resetPasswordWithEmail(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  //Checking if the email exists in auth
  Future<bool> checkIfEmailExists(String email) async {
    bool exists = false;
    try {
      await _auth.fetchSignInMethodsForEmail(email);
      exists = true;
    } catch (e) {
      exists = false;
    }
    return exists;
  }

  // get user role consumer or business owner
  String getUserRole(String email) {
    String role = '';
    _firestore
        .collection('users')
        .where('email', isEqualTo: getUserEmail)
        .get()
        .then((users) {
      for (var user in users.docs) {
        if (user['email'] == getUserEmail) {
          role = user['role'];
        }
      }
    });
    return role;
  }

  // get email form auth
  String get getEmail {
    return _auth.currentUser!.email!;
  }

  Future resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut() {
    return _auth.signOut();
  }

  StreamBuilder getStreamBuilder() {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the authentication state
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          User? user = snapshot.data;
          if (user != null) {
            // Check if the authentication provider is Google
            if (user.providerData
                .any((userInfo) => userInfo.providerId == 'google.com')) {
              // Navigate to the ConsumerHomeScreen
              return const ConsumerHomeScreen();
            } else {
              // User is registered, check their role in Firestore
              return StreamBuilder<DocumentSnapshot>(
                stream:
                    _firestore.collection('users').doc(getEmail).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for the Firestore data
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    String? role = snapshot.data!.get('role');
                    if (role == 'consumer') {
                      // Navigate to the ConsumerHomeScreen
                      return const ConsumerHomeScreen();
                    } else if (role == 'businessOwner') {
                      // Navigate to the RestaurantHomeScreen
                      return const RestaurantHomeScreen();
                    }
                  }
                  // Handle empty Firestore data
                  return const Text('משתמש לא קיים');
                },
              );
            }
          }
        }
        // User is not authenticated, show the login screen
        return const AuthScreen();
      },
    );
  }
}
