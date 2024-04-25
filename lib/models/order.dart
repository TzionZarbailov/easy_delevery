import 'package:easy_delevery/models/menu_item.dart';

class Order {
  final String
      consumerId; //*This is the id of the consumer who placed the order
  final String
      busniessOwnersId; //*This is the id of the restaurant where the order is placed
  final List<MenuItem> items; //*This is the id of the menu item ordered

  final int totalAmount; //*This is the quantity of the item ordered
  final double totalPrice; //*This is the total price of the order
  final String orderStatus; //*This is the status of the order
  final DateTime orderTime; //*This is the time when the order is placed
  final List<String> comments;
  final bool?
      pickUpOrDelivery; //*If it is false then it is TA if it is true then it is delivery

  const Order({
    required this.consumerId,
    required this.busniessOwnersId,
    required this.items,
    required this.totalAmount,
    required this.totalPrice,
    required this.orderStatus,
    required this.orderTime,
    required this.comments,
    this.pickUpOrDelivery,
  });

  // get all consumerId of the order List
  List<String> getConsumerId(List<Order> orders) {
    List<String> consumerId = [];
    for (Order order in orders) {
      consumerId.add(order.consumerId);
    }
    return consumerId;
  }

  // get all quantity of the order List
  static int getTotalQuantity(List<Order> orders) {
    int totalQuantity = 0;
    for (Order order in orders) {
      totalQuantity += order.totalAmount;
    }
    return totalQuantity;
  }

  // get all price of the order List
  static double getTotalPrice(List<Order> orders) {
    double totalPrice = 0;
    for (Order order in orders) {
      totalPrice += order.totalPrice;
    }
    return totalPrice;
  }

  // map the data from the database to the Order object
  Map<String, dynamic> toMap() {
    return {
      'consumerId': consumerId,
      'busniessOwnersId': busniessOwnersId,
      'items': items,
      'totalAmount': totalAmount,
      'totalPrice': totalPrice,
      'comments': comments,
      'orderStatus': orderStatus,
      'orderTime': orderTime,
      'pickUpOrDelivery': pickUpOrDelivery,
    };
  }

  // map the data from the Order object to the database
  Order.fromMap(Map<String, dynamic> map)
      : consumerId = map['consumerId'],
        busniessOwnersId = map['busniessOwnersId'],
        items = map['items'],
        totalAmount = map['totalAmount'],
        totalPrice = map['totalPrice'],
        comments = map['comments'],
        orderStatus = map['orderStatus'],
        orderTime = map['orderTime'],
        pickUpOrDelivery = map['pickUpOrDelivery'];
}
