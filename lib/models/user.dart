class User {
  final String id; //* This is the id of the user
  final String name; //* This is the name of the user
  final String email; //* This is the email of the user
  final String password; //* This is the password of the user
  final String userType; //* This is the type of the user
  final String address; //* This is the address of the user
  final String phoneNumber; //* This is the phone number of the user

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.userType,
    required this.address,
    required this.phoneNumber,
  });
}
