import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/screens/auth_screen.dart';
import 'package:easy_delevery/screens/consumer_screens/consumer_home.dart';
import 'package:easy_delevery/screens/business_screens/restaurant_home_screen.dart';
import 'package:easy_delevery/screens/consumer_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StreamServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

   String get getEmail {
    return _auth.currentUser!.email!;
  }

  //* StreamBuilder for the home screen consumer or business owner
  StreamBuilder getStreamHomeScreen() {
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
              return const HomeScreen();
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
                      return const HomeScreen();
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