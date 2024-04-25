import 'package:easy_delevery/models/menu_item.dart';
import 'package:easy_delevery/models/order.dart';
import 'package:easy_delevery/screens/consumer_screens/payment_screen.dart';
import 'package:flutter/material.dart';

class ShoppingCart extends StatefulWidget {
  final List<Order> orders;
  final String restaurantDocId;

  const ShoppingCart({
    Key? key,
    required this.orders,
    required this.restaurantDocId,
  }) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(65.0), // Provide the height of the AppBar.
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF8E3CA),
                Color(0xC8F4AE5C),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, widget.orders.length);
              },
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'ההזמנה שלך',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: ListView.builder(
                itemCount: widget.orders.length,
                itemBuilder: (context, index) {
                  final order = widget.orders[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.orange[100],
                            title: const Text(
                              'שינויים',
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              order.comments.isEmpty
                                  ? 'אין שינויים במנה'
                                  : order.comments
                                      .map((comment) =>
                                          comment.replaceFirst('', 'בלי '))
                                      .join('\n'),
                              textAlign: TextAlign.right,
                            ),
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.orange[200],
                                  ),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(horizontal: 25),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Center(
                                  child: Text(
                                    'סגור',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFF8E3CA),
                            Color(0xC8F4AE5C),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Card(
                        color: Colors.transparent,
                        shadowColor: Colors.transparent,
                        elevation: 0,
                        child: ListTile(
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // icon delete order
                              IconButton(
                                onPressed: () {
                                  // delete order
                                  setState(() {
                                    widget.orders.removeAt(index);
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),

                              Text(
                                order.items[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Text(
                                'ש"ח',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                order.totalPrice.toStringAsFixed(2),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(width: 25),
                              Text(
                                '${MenuItem.getTotalQuantity(order.items)}  יחידות',
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          trailing: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              order.items[index].image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // total price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  Order.getTotalPrice(widget.orders).toStringAsFixed(2),
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                const Text(
                  ' :סה"כ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 65),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF8E3CA),
                  Color(0xC8F4AE5C),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                foregroundColor: Colors.yellow,
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                  vertical: 10,
                ),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      orders: widget.orders,
                      restaurantDoc: widget.restaurantDocId,
                    ),
                  ),
                );
              },
              child: const Text(
                'מעבר לתשלום',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
