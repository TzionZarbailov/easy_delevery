import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/restaurant.dart';
import 'package:easy_delevery/models/user.dart';

class RestaurantRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
}
