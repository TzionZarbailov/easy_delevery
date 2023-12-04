enum ConsumerValidationError {
  invalidEmail,
  invalidPassword,
  invalidFullName,
  invalidPhoneNumber,
  invalidCity,
  invalidAddress,
  none,
}

enum RestaurantValidationError {
  invalidEmail,
  invalidPassword,
  invalidFullName,
  invalidPhoneNumber,
  invalidRestaurantPhoneNumber,
  invalidCity,
  invalidAddress,
  invalidOpeningTime,
  invalidClosingTime,
  none,
}

class ValidationHelper {
  // Vaild for email
  static bool isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return regex.hasMatch(email);
  }

// Vaild for password
  static bool isValidPassword(String password) {
    final RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );
    return regex.hasMatch(password);
  }

// Vaild for phone number
  static bool isValidPhoneNumber(String phoneNumber) {
    final RegExp regex = RegExp(
      r'^[0-9]{10}$',
    );
    return regex.hasMatch(phoneNumber);
  }

// Vaild for fullName
  static bool isValidFullName(String fullName) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z\u0590-\u05FF ]+$',
    );
    return regex.hasMatch(fullName);
  }

// Vaild for address
  static bool isValidAddress(String address) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9\u0590-\u05FF ]+$',
    );
    return regex.hasMatch(address);
  }

// Check if the restaurant is open
  static bool isRestaurantOpen(String openingTime, String closingTime) {
    // Parse the opening and closing times
    final openingHour = int.parse(openingTime.split(':')[0]);
    final openingMinute = int.parse(openingTime.split(':')[1]);
    final closingHour = int.parse(closingTime.split(':')[0]);
    final closingMinute = int.parse(closingTime.split(':')[1]);

    // Get the current time
    final now = DateTime.now();

    // Create DateTime objects for the opening and closing times
    final openingDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      openingHour,
      openingMinute,
    );
    final closingDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      closingHour,
      closingMinute,
    );

    // Check if the current time is within the opening and closing times
    return now.isAfter(openingDateTime) && now.isBefore(closingDateTime);
  }

  // is the city in israel?
  static Future<bool> isCityInIsrael(String city) {
    // Implement your logic here to check if the city is in Israel
    // This is just a placeholder implementation
    return Future.value(true);
  }
}
