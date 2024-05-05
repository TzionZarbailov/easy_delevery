import 'package:easy_delevery/models/menu_item.dart';

class Shipping {
  final MenuItem items; //*This is the id of the menu item ordered
  final int amount; //*This is the quantity of the item ordered
  final double price; //*This is the total price of the order
  final List<String> comments;

  const Shipping({
    required this.items,
    required this.amount,
    required this.price,
    required this.comments,
  });

  // get all quantity of the order List
  static int getQuantity(List<Shipping> orders) {
    int totalQuantity = 0;
    for (Shipping order in orders) {
      totalQuantity += order.amount;
    }
    return totalQuantity;
  }

  // get all price of the order List
  static double getPrice(List<Shipping> orders) {
    double totalPrice = 0;
    for (Shipping order in orders) {
      totalPrice += order.price;
    }
    return totalPrice;
  }

  // map the data from the database to the Order object
  Map<String, dynamic> toMap() {
    return {
      'items': items.toMap(), // Assuming MenuItem has a toMap() method
      'amount': amount,
      'price': price,
      'comments': comments,
    };
  }

// map the data from the Order object to the database
  factory Shipping.fromMap(Map<String, dynamic> map) {
    return Shipping(
      items: MenuItem.fromMap(map['items']),
      amount: map['amount'],
      price: map['price'],
      comments: List<String>.from(map['comments']),
    );
  }
}
