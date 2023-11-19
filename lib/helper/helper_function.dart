// ignore: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

//! Password correctness
bool isPasswordCorrect() {
  return true;
}

//! Email correctness
bool isEmailCorrect() {
  return true;
}

//! signIn functions
Future signIn(
    TextEditingController email, TextEditingController password) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email.text.trim(),
    password: password.text.trim(),
  );
}
Future<void> addUserToFirestore(User user) async {
  await FirebaseFirestore.instance.collection('users').doc(user.id).set({
    'name': user.name,
    'email': user.email,
    'password': user.password,
    'userType': user.userType,
    'address': user.address,
    'phoneNumber': user.phoneNumber,
  });
}

//! login with google
void loginWithGoogle() {}

//! login with facebook
void loginWithFacebook() {}

//! reset password
void resetPassword() {}

//! reset password with email
void resetPasswordWithEmail() {}

//! reset password with phone number
void resetPasswordWithPhone() {}

//! reset password with email or phone number
void resetPasswordWithEmailOrPhone() {}
