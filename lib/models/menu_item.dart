import 'package:easy_delevery/models/category.dart';
import 'package:flutter/material.dart';

enum MenuItemType {
  starter, //*This is the starter menu item
  mainCourse, //*This is the main course menu item
  dessert, //*This is the dessert menu item
  drink, //*This is the drink menu item
}

class MenuItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final Category category;
  final Image image;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
  });
}
