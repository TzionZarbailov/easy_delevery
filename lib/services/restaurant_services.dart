import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/restaurant.dart';

class RestaurantServices {
  // get collection of restaurants
  final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  // CREATE: add a new restaurant and doc is restaurant id in business owner 
  Future<void> addRestaurant(Restaurant restaurant) async {
    await restaurants.doc(restaurant.id).set(restaurant.toMap());
  }

  // READ: Get a restaurant by id and return a QuerySnapshot
  Stream<QuerySnapshot> getRestaurant() {
    final restaurantStream = restaurants.orderBy('id', descending: true).snapshots();

    return restaurantStream;
  }

  // UPDATE: update a restaurant
  Future<void> updateRestaurant(String id, Map<String, dynamic> newdata) async {
    await restaurants.doc(id).update(newdata);
  }

    

}
