import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/category.dart';
import 'package:easy_delevery/models/menu_item.dart';

class Restaurant {
  final String id; //*This is the id of the restaurant
  final String name; //*This is the name of the restaurant
  final String? restaurantImage;
  final String address; //*This is the address of the restaurant
  final String? phoneNumber; //*This is the phone number of the restaurant
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
    required this.phoneNumber,
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
      'categories': categories?.map((category) => category.toMap()).toList(),
      'menuItems': menuItems?.map((menuItem) => menuItem.toMap()).toList(),
    };
  }

  factory Restaurant.fromDocument(DocumentSnapshot doc) {
    return Restaurant(
      id: doc.id,
      name: doc['name'],
      restaurantImage: doc['restaurantImage'],
      address: doc['address'],
      phoneNumber: doc['phoneNumber'],
      isOpen: doc['isOpen'],
      restaurantType: doc['restaurantType'],
      categories: (doc['categories'] as List<dynamic>?)
          ?.map((item) => Category.fromMap(item as Map<String, dynamic>))
          .toList(),
      menuItems: (doc['menuItems'] as List<dynamic>?)
          ?.map((item) => MenuItem.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      restaurantImage: map['restaurantImage'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      isOpen: map['isOpen'],
      restaurantType: map['restaurantType'],
      categories: (map['categories'] as List<dynamic>?)
          ?.map((item) => Category.fromMap(item as Map<String, dynamic>))
          .toList(),
      menuItems: (map['menuItems'] as List<dynamic>?)
          ?.map((item) => MenuItem.fromMap(item as Map<String, dynamic>))
          .toList(),
    );
  }

  void addMenuItem(MenuItem menuItem) {
    menuItems!.add(menuItem);
  }

  void removeMenuItem(MenuItem menuItem) {
    menuItems!.remove(menuItem);
  }
}
