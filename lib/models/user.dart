class User {
  final String fullName; //* This is the name of the user
  final String email; //* This is the email of the user
  final String password; //* This is the password of the user
  final String phoneNumber; //* This is the phone number of the user
  final String city; //* This is the city of the user
  final String address; //* This is the address of the user
  final String role;

  const User({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.city,
    required this.address,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'city': city,
      'address': address,
      'role': role,
    };
  }
}

class Consumer extends User {
  final String floor;
  final String apartmentNumber;

  Consumer({
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String city,
    required String address,
    required String role,
    required this.floor,
    required this.apartmentNumber,
  }) : super(
          fullName: fullName,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          city: city,
          address: address,
          role: role,
        );

  Consumer.fromMap(Map<String, dynamic> map)
      : this(
          email: map['email'],
          password: map['password'],
          fullName: map['fullName'],
          address: map['address'],
          floor: map['floor'],
          city: map['city'],
          apartmentNumber: map['apartmentNumber'],
          phoneNumber: map['phoneNumber'],
          role: map['role'],
        );

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['address'] = address;
    map['floor'] = floor;
    map['apartmentNumber'] = apartmentNumber;
    return map;
  }
}

class BusinessOwner extends User {
  final String businessName;
  final String businessPhone;
  final String workHours;
  final String restaurantId;

  BusinessOwner({
    required this.restaurantId,
    required String fullName,
    required String email,
    required String password,
    required String phoneNumber,
    required String city,
    required String address,
    required String role,
    required this.businessName,
    required this.businessPhone,
    required this.workHours,
  }) : super(
          email: email,
          password: password,
          fullName: fullName,
          phoneNumber: phoneNumber,
          city: city,
          address: address,
          role: role,
        );

  BusinessOwner.fromMap(Map<String, dynamic> map)
      : this(
          restaurantId: map['restaurantId'],
          email: map['email'],
          password: map['password'],
          fullName: map['fullName'],
          businessName: map['businessName'],
          phoneNumber: map['phoneNumber'],
          businessPhone: map['businessPhone'],
          city: map['city'],
          address: map['address'],
          workHours: map['workHours'],
          role: map['role'],
        );

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['restaurantId'] = restaurantId;
    map['businessName'] = businessName;
    map['businessPhone'] = businessPhone;
    map['workHours'] = workHours;
    return map;
  }
}
