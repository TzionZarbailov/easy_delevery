import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:flutter/material.dart';

class GetUserEmail extends StatelessWidget {
  final String docId;

  const GetUserEmail({
    super.key,
    required this.docId,
  });

  @override
  Widget build(BuildContext context) {
    // get the collectio users
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc().get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if(data['email'] == AuthServices.getEmail) {
            return Text(
              data['email'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            );
          }
        }
        return const Text("loading...");
      },
    );
  }
}
