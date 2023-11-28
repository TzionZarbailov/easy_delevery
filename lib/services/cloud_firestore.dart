import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/user.dart';

// FirestoreCollection: collection names in the database
class FirestoreCollection {
  static const String consumer = 'consumer';
  static const String businessOwner = 'businessOwner';
}


class FirestoreService {
// get collection of consumer
  Stream<QuerySnapshot> getConsumer() {
    return FirebaseFirestore.instance
        .collection(FirestoreCollection.consumer)
        .snapshots();
  }

// get collection of business owner
  Stream<QuerySnapshot> getBusinessOwner() {
    return FirebaseFirestore.instance
        .collection(FirestoreCollection.businessOwner)
        .snapshots();
  }

  // Create:add a consumer to the database
  Future<void> addConsumer(Consumer user) {
    return FirebaseFirestore.instance
        .collection(FirestoreCollection.consumer)
        .add(user.toMap());
  }

  // Create: add a business owner to the database
  Future<void> addBusinessOwner(BusinessOwner user) {
    return FirebaseFirestore.instance
        .collection(FirestoreCollection.businessOwner)
        .add(user.toMap());
  }

  // Read: get a consumer by id
  Future<Consumer> getConsumerById(String id) async {
    var doc = await FirebaseFirestore.instance
        .collection(FirestoreCollection.consumer)
        .doc(id)
        .get();
    if (doc.data() != null) {
      return Consumer.fromMap(doc.data()!);
    } else {
      throw Exception('Document does not exist in the database');
    }
  }

  // Read: get a business owner by id
  Future<BusinessOwner> getBusinessOwnerById(String id) async {
    var doc = await FirebaseFirestore.instance
        .collection(FirestoreCollection.businessOwner)
        .doc(id)
        .get();
    if (doc.data() != null) {
      return BusinessOwner.fromMap(doc.data()!);
    } else {
      throw Exception('Document does not exist in the database');
    }
  }

  // Update: update a consumer in the database
Future<void> updateConsumer(String id, Consumer user) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollection.consumer)
      .doc(id)
      .update(user.toMap());
}

// Update: update a business owner in the database
Future<void> updateBusinessOwner(String id, BusinessOwner user) {
  return FirebaseFirestore.instance
      .collection(FirestoreCollection.businessOwner)
      .doc(id)
      .update(user.toMap());
}
}


