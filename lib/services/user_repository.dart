import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  //* Instance of FirebaseAuth and FirebaseFirestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //* Instance of GoogleSignIn
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //* Collection names in the database

  //* Stream of consumers
  Stream<QuerySnapshot> getUser() {
    return _firestore.collection('users').snapshots();
  }

  // add consumer to the database
  Future<void> addConsumer(Consumer user) {
    return _firestore
        .collection('users')
        .doc(user.email) // Use the business owner's email as the document ID
        .set(user.toMap());
  }

  // add business owner to the database
  Future<void> addBusinessOwners(BusinessOwner user) {
    return _firestore.collection('users').doc(user.email).set(user.toMap());
  }

  //* Are the password and email correct?
  Future<bool> isEmailAndPasswordCorrect(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    if (user.user != null) {
      return true;
    }
    return false;
  }

  // uuid of the current user
  String getUid() {
    return _auth.currentUser!.uid;
  }
  
  //! reset password from phone number
  Future<void> resetPasswordPhone(String phone) {
    return _auth.sendPasswordResetEmail(email: phone);
  }
  // If the user successfully logs in using gmail then he will go to the consumer home screen otherwise he will give an error message

  //* Sign in using google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleSignIn = await GoogleSignIn().signIn();

    // If googleUser is null, handle this case appropriately
    if (googleSignIn == null) {
      throw Exception('Google sign in failed');
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleSignIn.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //* register with email and password
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  // sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  // reset password from email
  Future<void> resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  // sign out
  Future<void> signOut() {
    return _auth.signOut();
  }
}
