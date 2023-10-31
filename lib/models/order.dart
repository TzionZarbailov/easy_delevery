class Order {
  final String id;
  final String consumerId;
  final String restaurantId;
  final String menuItemId;
  final int quantity;
  final double totalPrice;
  final String orderStatus;
  final DateTime orderTime;
  final bool pickUpOrDelivery;

  const Order({
    required this.id,
    required this.consumerId,
    required this.restaurantId,
    required this.menuItemId,
    required this.quantity,
    required this.totalPrice,
    required this.orderStatus,
    required this.orderTime,
    required this.pickUpOrDelivery,
  });
}
