import 'package:easy_delevery/models/order.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final List<Order> orders;
  final String restaurantDoc;
  const PaymentScreen({
    Key? key,
    required this.orders,
    required this.restaurantDoc,
  }) : super(key: key);

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
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'תשלום',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
