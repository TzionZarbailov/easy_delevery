class ValidationHelper {
  // Vaild for email

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    return regex.hasMatch(email);
  }

// Vaild for password
  bool isValidPassword(String password) {
    final RegExp regex = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );

    return regex.hasMatch(password);
  }

// Vaild for phone number
  bool isValidPhoneNumber(String phoneNumber) {
    final RegExp regex = RegExp(
      r'^[0-9]{10}$',
    );
    return regex.hasMatch(phoneNumber);
  }

// Vaild for fullName
  bool isValidFullName(String fullName) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z\u0590-\u05FF ]+$',
    );

    if (!regex.hasMatch(fullName)) {
      return false;
    }

    final List<String> names = fullName.split(' ');
    // Check that there are at least two names
    return names.length >= 2;
  }

// Vaild for address
  bool isValidAddress(String address) {
    final RegExp regex = RegExp(
      r'^[a-zA-Z0-9\u0590-\u05FF ]+$',
    );
    return regex.hasMatch(address);
  }

// Check if the restaurant is open
  bool isRestaurantOpen(String openingTime, String closingTime) {
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
}
