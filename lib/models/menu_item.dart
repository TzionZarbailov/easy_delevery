import 'package:easy_delevery/models/category.dart';
import 'package:flutter/material.dart';

enum MenuItemType {
  starter,
  mainCourse,
  dessert,
  drink,
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
