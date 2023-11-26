class User {
  final String id; //* This is the id of the user
  final String name; //* This is the name of the user
  final String email; //* This is the email of the user
  final String password; //* This is the password of the user
  final String phoneNumber; //* This is the phone number of the user
  final String city; //* This is the city of the user

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.city,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'city': city,
    };
  }
}

class Consumer extends User {
  final String address;
  final int floor;
  final int apartmentNumber;

  const Consumer({
    required String id,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String city,
    required this.address,
    required this.floor,
    required this.apartmentNumber,
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          city: city,
        );

  Consumer.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          password: map['password'],
          address: map['address'],
          phoneNumber: map['phoneNumber'],
          floor: map['floor'],
          city: map['city'],
          apartmentNumber: map['apartmentNumber'],
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

  const BusinessOwner({
    required String id,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String city,
    required this.businessName,
    required this.businessPhone,
    required this.workHours,
  }) : super(
          id: id,
          name: name,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          city: city,
        );

  BusinessOwner.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          name: map['name'],
          email: map['email'],
          password: map['password'],
          phoneNumber: map['phoneNumber'],
          businessName: map['businessName'],
          businessPhone: map['businessPhone'],
          city: map['city'],
          workHours: map['workHours'],
        );

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map['businessName'] = businessName;
    map['businessPhone'] = businessPhone;
    map['workHours'] = workHours;
    return map;
  }
}
