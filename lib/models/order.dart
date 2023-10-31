class Order {
  final String id;
  final String consumerId; //*This is the id of the consumer who placed the order
  final String restaurantId; //*This is the id of the restaurant where the order is placed
  final String menuItemId; //*This is the id of the menu item ordered
  final int quantity; //*This is the quantity of the item ordered
  final double totalPrice; //*This is the total price of the order
  final String orderStatus; //*This is the status of the order
  final DateTime orderTime; //*This is the time when the order is placed
  final bool pickUpOrDelivery; //*If it is false then it is TA if it is true then it is delivery

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
