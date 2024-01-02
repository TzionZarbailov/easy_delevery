import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;
      return user;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // signInWithGoogle
  Future signInWithGoogle() async {
    try {
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
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      User? user = result.user;
      return user;
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // reset password
  Future resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // change password
  Future changePassword(String password) async {
    try {
      await _auth.currentUser!.updatePassword(password.trim());
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }
}
