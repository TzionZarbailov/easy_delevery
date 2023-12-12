import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:easy_delevery/services/user_repository.dart';

class RestaurantRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserRepository _userRepository = UserRepository();

  final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('restaurants');

  Future addRestaurant(Restaurant restaurant) async {
    await restaurants.doc().set(restaurant.toMap());
  }    
}
