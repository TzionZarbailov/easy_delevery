import 'package:easy_delevery/models/shipping.dart';

class Order {
  final String consumerId;
  final String restaurantId;
  final String consumerName;
  final String consumerAddress;
  final String resturantName;
  final List<Shipping> shipping;
  final int totalAmount; // total quantity of the order
  final double totalPirce; // total price of the order
  final String remarks; // remarks of the order
  final String consumerPhoneNumber; // phone number of the consumer
  final String orderStatus; // status of the order
  final bool deliveryOrCollction; // if false then collection else delivery
  final bool cashOrCredit; // if false then cash else credit
  final DateTime orderTime; // time of the order

  Order({
    required this.consumerId,
    required this.restaurantId,
    required this.resturantName,
    required this.consumerName,
    required this.consumerAddress,
    required this.shipping,
    required this.totalAmount,
    required this.totalPirce,
    required this.remarks,
    required this.consumerPhoneNumber,
    required this.orderStatus,
    required this.deliveryOrCollction,
    required this.cashOrCredit,
    required this.orderTime,
  });

  // factory Order.fromMap(Map<String, dynamic> map)
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      consumerId: map['consumerId'],
      restaurantId: map['restaurantId'],
      resturantName: map['resturantName'],
      consumerName: map['consumerName'],
      consumerAddress: map['consumerAddress'],
      shipping: List<Shipping>.from(map['shipping']),
      totalAmount: map['totalAmount'],
      totalPirce: map['totalPirce'],
      remarks: map['remarks'],
      consumerPhoneNumber: map['consumerPhoneNumber'],
      orderStatus: map['orderStatus'],
      deliveryOrCollction: map['deliveryOrCollction'],
      cashOrCredit: map['cashOrCredit'],
      orderTime: map['orderTime'],
    );
  }

  // Order.topMap()
  Map<String, dynamic> toMap() {
    return {
      'consumerId': consumerId,
      'restaurantId': restaurantId,
      'resturantName': resturantName,
      'consumerName': consumerName,
      'consumerAddress': consumerAddress,
      'shipping': shipping
          .map((item) => item.toMap())
          .toList(), // Assuming Shipping has a toMap() method
      'totalAmount': totalAmount,
      'totalPirce': totalPirce,
      'remarks': remarks,
      'consumerPhoneNumber': consumerPhoneNumber,
      'orderStatus': orderStatus,
      'deliveryOrCollction': deliveryOrCollction,
      'cashOrCredit': cashOrCredit,
      'orderTime': orderTime, // Convert DateTime to int
    };
  }
}
