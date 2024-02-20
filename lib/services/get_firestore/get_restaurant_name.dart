import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class GetRestaurantName extends StatelessWidget {
  const GetRestaurantName({
    super.key,
    required this.documentId,
  });

  final String documentId;

  @override
  Widget build(BuildContext context) {
    // get the collection

    CollectionReference restaurants =
        FirebaseFirestore.instance.collection('restaurants');

    return FutureBuilder<DocumentSnapshot>(
      future: restaurants.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const Text("loading...");
        } else {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text(
            data['name'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          );
        }
      },
    );
  }
}
