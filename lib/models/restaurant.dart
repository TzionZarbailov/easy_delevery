import 'package:easy_delevery/models/category.dart';
import 'package:easy_delevery/models/menu_item.dart';

class Restaurant {
  final String id;
  final String name;
  final String address;
  final bool isOpen;
  final List<Category> categories;
  final List<MenuItem> menuItems;

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
