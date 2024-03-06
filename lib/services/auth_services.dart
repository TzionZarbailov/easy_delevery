// ignore_for_file: use_rethrow_when_possible, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  String get getUid {
    return _auth.currentUser!.uid;
  }

  static String get getEmail {
    return _auth.currentUser!.email!;
  }

  // sign in with email and password
  static Future signInWithEmailAndPassword(
      String email, String password) async {
    await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  // signInWithGoogle
  static Future signInWithGoogle() async {
    //* begin interactive sign-in process
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();
    //* obtain the auth details from the request
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    //* create a new credential user
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    //* finally, lets sign in
    await _auth.signInWithCredential(credential);
  }

  // register with email and password
  static Future registerWithEmailAndPassword(
      String email, String password) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim());
    User? user = result.user;
    return user;
  }

  // sign out
  static Future signOut() async {
    await _auth.signOut();
  }

  // reset password
  Future resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email.toString());
  }

  // checkIfEmailExists
  Future<bool> checkIfEmailExists(String email) async {
    final List<String> signInMethods =
        await _auth.fetchSignInMethodsForEmail(email);

    // אם יש כלל חשבון קשור לאימייל, המשתמש קיים
    if (signInMethods.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // change password
  Future changePassword(String password) async {
    await _auth.currentUser!.updatePassword(password.trim());
  }
}
