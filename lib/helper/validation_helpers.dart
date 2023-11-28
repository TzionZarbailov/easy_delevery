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
  return regex.hasMatch(fullName);
}

// Vaild for address
bool isValidAddress(String address) {
  final RegExp regex = RegExp(
    r'^[a-zA-Z0-9\u0590-\u05FF ]+$',
  );
  return regex.hasMatch(address);
}
