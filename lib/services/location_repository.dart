import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class LocationRepository {
  // is the city in israel?
  Future<bool> isCityInIsrael(String city) async {
    final response = await http.get(
      Uri.parse(
          'http://api.geonames.org/searchJSON?q=$city&maxRows=10&username=demo'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final firstMatch = data['geonames'].firstWhere(
        (cityData) {
          final alternateNames =
              cityData['alternateNames'] as List<dynamic>? ?? [];
          return cityData['name'].toLowerCase() == city.toLowerCase() ||
              alternateNames.any(
                  (name) => name['name'].toLowerCase() == city.toLowerCase());
        },
        orElse: () => null,
      );

      if (firstMatch != null) {
        return firstMatch['countryName'] == 'Israel';
      }
    }

    return false;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295; // Math.PI / 180
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  // Checks if the restaurant's city is close to the consumer's city within 4 kilometers
  Future<bool> isRestaurantCloseToConsumer(
      String restaurantCity, String consumerCity) async {
    final response = await http.get(
      Uri.parse(
          'http://api.geonames.org/searchJSON?q=$restaurantCity&maxRows=10&username=demo'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final firstMatch = data['geonames'].firstWhere(
        (cityData) {
          final alternateNames =
              cityData['alternateNames'] as List<dynamic>? ?? [];
          return cityData['name'].toLowerCase() ==
                  restaurantCity.toLowerCase() ||
              alternateNames.any((name) =>
                  name['name'].toLowerCase() == restaurantCity.toLowerCase());
        },
        orElse: () => null,
      );

      if (firstMatch != null) {
        final restaurantLatitude = double.parse(firstMatch['lat']);
        final restaurantLongitude = double.parse(firstMatch['lng']);

        final consumerResponse = await http.get(
          Uri.parse(
              'http://api.geonames.org/searchJSON?q=$consumerCity&maxRows=10&username=demo'),
        );

        if (consumerResponse.statusCode == 200) {
          final consumerData = jsonDecode(consumerResponse.body);
          final consumerFirstMatch = consumerData['geonames'].firstWhere(
            (cityData) {
              final alternateNames =
                  cityData['alternateNames'] as List<dynamic>? ?? [];
              return cityData['name'].toLowerCase() ==
                      consumerCity.toLowerCase() ||
                  alternateNames.any((name) =>
                      name['name'].toLowerCase() == consumerCity.toLowerCase());
            },
            orElse: () => null,
          );

          if (consumerFirstMatch != null) {
            final consumerLatitude = double.parse(consumerFirstMatch['lat']);
            final consumerLongitude = double.parse(consumerFirstMatch['lng']);

            final distance = calculateDistance(
              restaurantLatitude,
              restaurantLongitude,
              consumerLatitude,
              consumerLongitude,
            );

            return distance <= 4;
          }
        }
      }
    }

    return false;
  }
}
