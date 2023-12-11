import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:easy_delevery/screens/consumer_home_screen.dart';
import 'package:easy_delevery/screens/restaurant_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // add business owner to firestore
  Future addBusinessOwner(BusinessOwner businessOwner) async {
    await users.doc(businessOwner.email.trim()).set(businessOwner.toMap());
  }

  Future addConsumer(Consumer consumer) async {
    await users.doc(consumer.email).set(consumer.toMap());
  }

  // sign in with email and password
  Future<UserCredential> signIn(String email, String password) async {
  try {
    final userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Check if the userCredential is null or has an empty user UID
    if (userCredential.toString().isEmpty || userCredential.user?.uid == null) {
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
  Future registerBusinessOwner(BusinessOwner businessOwner) async {
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
  Future registerConsumer(Consumer consumer) async {
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

  // password reset
  Future resetPasswordWithEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // bool if user email equals to email in _firestore
  bool isUserExist(String email) {
    bool isExist = false;
    _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get()
        .then((users) {
      for (var user in users.docs) {
        if (user['email'] == email) {
          isExist = true;
        }
      }
    });
    return isExist;
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

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) throw Exception('Google sign in failed');

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut() {
    return _auth.signOut();
  }

  StreamBuilder getStreamBuilder() {
    return StreamBuilder(
      stream: _firestore.collection('users').doc(getEmail).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data['role'] == 'consumer') {
          return const ConsumerHomeScreen();
        } else {
          return const RestaurantHomeScreen();
        }
      },
    );
  }
}
