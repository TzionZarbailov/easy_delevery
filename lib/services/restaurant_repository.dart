import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:easy_delevery/services/user_repository.dart';

class RestaurantRepository {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final UserRepository userRepository = UserRepository();

  final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  Future addRestaurant(Restaurant restaurant) async {
    await restaurants.doc().set(restaurant.toMap());
  }    
}
