class User {
  final String id; //* This is the id of the user
  final String fullName; //* This is the name of the user
  final String email; //* This is the email of the user
  final String phoneNumber; //* This is the phone number of the user
  final String city; //* This is the city of the user
  final String address; //* This is the address of the user

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'address': address,
    };
  }
}

class Consumer extends User {
  
  final int floor;
  final int apartmentNumber;

  const Consumer({
    required String id,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String city,
    required String address,
    required this.floor,
    required this.apartmentNumber,
  }) : super(
          id: id,
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          city: city,
          address: address,
        );

  Consumer.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          fullName: map['fullName'],
          email: map['email'],
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
    required String fullName,
    required String email,
    required String phoneNumber,
    required String city,
    required String address,
    required this.businessName,
    required this.businessPhone,
    required this.workHours,
  }) : super(
          id: id,
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          city: city,
          address: address,
        );

  BusinessOwner.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'],
          fullName: map['fullName'],
          email: map['email'],
          phoneNumber: map['phoneNumber'],
          businessName: map['businessName'],
          businessPhone: map['businessPhone'],
          city: map['city'],
          address: map['address'],
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
