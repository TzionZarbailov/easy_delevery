import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/services/auth_services.dart';

class OrderServices {
  static final CollectionReference _orders =
      FirebaseFirestore.instance.collection('orders');

  // CREATE: add a new order
  static Future<void> addOrder(Map<String, dynamic> order) async {
    try {
      await _orders.doc().set(order);
    } catch (e) {
      print('Error adding order: $e');
    }
  }

  // Get: get a order by doc id order by order id
  static Future getOrder() async {
    DocumentSnapshot doc = await _orders.doc(AuthServices.getUid).get();

    return doc.data() as Order;
  }

  // UPDATE: update a order by order id
  static Future<void> updateOrder(
      String orderId, Map<String, dynamic> newdata) async {
    await _orders.doc(orderId).update(newdata);
  }
}
