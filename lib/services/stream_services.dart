// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/screens/auth_screen.dart';
import 'package:easy_delevery/screens/business_screens/restaurant_home_screen.dart';
import 'package:easy_delevery/screens/consumer_screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StreamServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // gey document id of the current user in the firestore collection users

  String get getEmail {
    return _auth.currentUser!.email!;
  }

  Future<String?> checkEmailInFirestore() async {
    // Get the current user
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Get the user's email
      final email = user.email;

      if (email != null) {
        // Query the Firestore collection
        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: email)
            .get();

        // If the query returns at least one document, return the ID of the first document
        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first.id;
        }
      }
    }

    // If the user is not logged in, the user doesn't have an email, or the email doesn't exist in Firestore, return null
    return null;
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
              return FutureBuilder<String?>(
                future: checkEmailInFirestore(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Show a loading indicator while waiting for the Firestore data
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData) {
                    String? docId = snapshot.data;
                    if (docId != null) {
                      // The email exists in Firestore, do something with the docId
                      return StreamBuilder<DocumentSnapshot>(
                        stream: _firestore
                            .collection('users')
                            .doc(docId)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Show a loading indicator while waiting for the Firestore data
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasData) {
                            String? role = snapshot.data!.get('role');
                            if (role == 'consumer') {
                              // Navigate to the ConsumerHomeScreen
                              print(docId);
                              return const HomeScreen();
                            } else if (role == 'businessOwner') {
                              // Navigate to the RestaurantHomeScreen
                              print(docId);
                              return const RestaurantHomeScreen();
                            }
                          }
                          // Handle empty Firestore data
                          return const Text('משתמש לא קיים');
                        },
                      );
                    }
                  }
                  // Handle error state
                  return const Text('An error occurred');
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
