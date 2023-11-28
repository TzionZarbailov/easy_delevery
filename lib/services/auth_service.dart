import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; // instance of firebase auth
  // add a user to the database
  Future<void> addUser(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // sign in a user
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // sign out a user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // get collection type of user
  Stream<QuerySnapshot> getUser() {
    return FirebaseFirestore.instance.collection('user').snapshots();
  }
 
  // Checks if mail already exists
  Future<bool> emailExists(String email) async {
  final List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
  return signInMethods.isNotEmpty;
}

  //* Read: get a user by id
  // Future<User> getUserById(String id) async {
  //   var doc = await FirebaseFirestore.instance.collection('user').doc(id).get();
  //   if (doc.data() != null) {
  //     return User.fromMap(doc.data()!);
  //   } else {
  //     throw Exception('Document does not exist in the database');
  //   }
  // }
}
