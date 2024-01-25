// ignore_for_file: use_rethrow_when_possible, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  String get getEmail {
    return _auth.currentUser!.email!;
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  // signInWithGoogle
  Future signInWithGoogle() async {
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
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
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
