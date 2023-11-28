import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

Future<bool> isCityInIsrael(String city) async {
  final response = await http.get(Uri.parse(
    'http://api.geonames.org/searchJSON?q=$city&country=IL&username=demo',
  ));
  final data = jsonDecode(response.body);

  // Check if the city is found in the response
  return data['geonames'].isNotEmpty;
}

Future<bool> isUserNearRestaurant(
    double restaurantLat, double restaurantLng, double radiusInMeters) async {
  // Get the current location of the user
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Calculate the distance between the user and the restaurant
  double distanceInMeters = Geolocator.distanceBetween(
    position.latitude,
    position.longitude,
    restaurantLat,
    restaurantLng,
  );

  // Check if the user is within the given radius of the restaurant
  return distanceInMeters <= radiusInMeters;
}
