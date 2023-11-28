import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LocationService {
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

  Future<bool> isAddressInCity(String address, String city) async {
    // Convert the address to coordinates
    List<Location> locations = await locationFromAddress(address);

    // If the geocoding service couldn't find the address, return false
    if (locations.isEmpty) {
      return false;
    }

    // Get the first result
    Location location = locations.first;

    // Convert the coordinates back to a placemark
    List<Placemark> placemarks = await placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );

    // If the geocoding service couldn't find the placemark, return false
    if (placemarks.isEmpty) {
      return false;
    }

    // Get the first result
    Placemark placemark = placemarks.first;

    // Check if the city of the placemark matches the given city
    return placemark.locality == city;
  }
}
