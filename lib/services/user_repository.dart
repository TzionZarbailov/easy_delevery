import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class UserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // sign in with email and password
  Future singIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // sign up with email and password
  Future signUp(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // password reset
  Future resetPasswordWithEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
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
  Future<DocumentReference> addConsumer(Consumer user) {
    return _firestore.collection('users').add(user.toMap());
  }

  // add businessOwners in users collection
  Future<DocumentReference> addBusinessOwners(BusinessOwner user) {
    return _firestore.collection('users').add(user.toMap());
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

  // get role from users collection in _firestore
  String getRole(String email) {
    bool isExist = isUserExist(email);
    String role = '';
    if (isExist) {
      _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get()
          .then((users) {
        for (var user in users.docs) {
          if (user['email'] == email) {
            role = user['role'];
          }
        }
      });
    }
    return role;
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

  Future signInWithEmailAndPassword(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future resetPassword(String email) {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future signOut() {
    return _auth.signOut();
  }
}
