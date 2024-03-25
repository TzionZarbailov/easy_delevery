import 'package:easy_delevery/models/category.dart';
import 'package:easy_delevery/models/menu_item.dart';

class Restaurant {
  final String id; //*This is the id of the restaurant
  final String name; //*This is the name of the restaurant
  final String? restaurantImage;
  final String address; //*This is the address of the restaurant
  final String city; //*This is the city of the restaurant
  final String? phoneNumber; //*This is the phone number of the restaurant
  final String workHours; //*This is the work hours of the restaurant
  final bool? isOpen; //*This is the status of the restaurant
  final String? restaurantType; //*This is the type of the restaurant
  final List<Category>?
      categories; //*This is the list of categories of the restaurant
  final List<MenuItem>?
      menuItems; //*This is the list of menu items of the restaurant

  const Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.phoneNumber,
    required this.workHours,
    required this.isOpen,
    this.restaurantImage,
    this.categories,
    this.menuItems,
    this.restaurantType,
  });
  // to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'restaurantImage': restaurantImage,
      'address': address,
      'phoneNumber': phoneNumber,
      'isOpen': isOpen,
      'restaurantType': restaurantType,
      'categories': categories,
      'menuItems': menuItems,
    };
  }

  // from map
  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      restaurantImage: map['restaurantImage'],
      address: map['address'],
      city: map['city'],
      phoneNumber: map['phoneNumber'],
      workHours: map['workHours'],
      isOpen: map['isOpen'],
      restaurantType: map['restaurantType'],
      categories: map['categories'],
      menuItems: map['menuItems'],
    );
  }

  void addMenuItem(MenuItem menuItem) {
    menuItems!.add(menuItem);
  }

  void removeMenuItem(MenuItem menuItem) {
    menuItems!.remove(menuItem);
  }
}
