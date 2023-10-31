import 'package:easy_delevery/models/category.dart';
import 'package:easy_delevery/models/menu_item.dart';

class Restaurant {
  final String id; //*This is the id of the restaurant
  final String name; //*This is the name of the restaurant
  final String address; //*This is the address of the restaurant
  final bool isOpen; //*This is the status of the restaurant
  final List<Category> categories; //*This is the list of categories of the restaurant
  final List<MenuItem> menuItems; //*This is the list of menu items of the restaurant

  const Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.isOpen,
    required this.categories,
    required this.menuItems,
  });

  void addMenuItem(MenuItem menuItem) {
    menuItems.add(menuItem);
  }

  void removeMenuItem(MenuItem menuItem) {
    menuItems.remove(menuItem);
  }
}
