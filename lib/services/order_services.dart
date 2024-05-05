// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

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

  //* Get: get orders by consumer id
  static Stream<QuerySnapshot> getOrderForConsumer(String consumerId) {
    return _orders.where('consumerId', isEqualTo: consumerId).snapshots();
  }

  // Get: get order
  static Stream<QuerySnapshot> myOrder() {
    return _orders.snapshots();
  }

  //* Get: get orders by restaurant id
  static Stream<QuerySnapshot> getOrderForRestaurant(String restaurantId) {
    return _orders
        .where('restaurantId', isEqualTo: restaurantId)
        .where('orderStatus', isEqualTo: "ממתין לאישור")
        .snapshots();
  }

  static Stream<QuerySnapshot> getOrderForRestaurantbyOrderStatus(
      String restaurantId, String orderStatus) {
    return _orders
        .where('restaurantId', isEqualTo: restaurantId)
        .where('orderStatus', isEqualTo: orderStatus)
        .snapshots();
  }

  static Future<void> updateOrderStatus(
      String orderId, Map<String, dynamic> newdata) async {
    _orders.doc(orderId).update(newdata);
  }
}
