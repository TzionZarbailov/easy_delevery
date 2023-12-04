import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Use an alias for FirebaseAuth
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future singIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // current user email
  String currentUserEmail() {
    return _auth.currentUser!.email!;
  }

  // get uid in auth
  String getCurrentUid() {
    return _auth.currentUser!.uid;
  }
  // add cunsomer in users collection
  Future<void> addConsumer(Consumer user, String uid) {
    return _firestore.collection('users').doc(uid).set(user.toMap());
  }
  // add businessOwners in users collection
  Future<void> addBusinessOwners(BusinessOwner user, String uid) {
    return _firestore.collection('users').doc(uid).set(user.toMap());
  }

  

  Future<UserCredential> signInWithGoogle() async {
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

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) {
    return _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() {
    return _auth.signOut();
  }
}
