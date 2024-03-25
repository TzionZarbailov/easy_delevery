import 'package:easy_delevery/models/restaurant.dart';
import 'package:flutter/material.dart';

class RestaurantDetails extends StatefulWidget {
  final Restaurant? restaurant;
  const RestaurantDetails({
    super.key,
    this.restaurant,
  });

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  @override
  Widget build(BuildContext context) {
    final Restaurant restaurant = widget.restaurant!;

    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
                bottomLeft: Radius.circular(17),
                bottomRight: Radius.circular(17),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 2),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(
                  restaurant.restaurantImage!,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const Text('Restaurant Name'),
          const Text('Restaurant Address'),
          // Add more details as needed
          const Text('Food Categories'),
          const Text('Prices'),
          ElevatedButton(
            onPressed: () {
              // Code to upload products
            },
            child: const Text('Upload Products'),
          ),
          ElevatedButton(
            onPressed: () {
              // Code to make a payment
            },
            child: const Text('Make a Payment'),
          ),
        ],
      ),
    );
  }
}
