import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/models/shipping.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:easy_delevery/services/order_services.dart';

import 'package:flutter/material.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'היסטורית הזמנות',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: myColors.buttonColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'בהכנה',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: OrderServices.getOrderForRestaurantbyOrderStatus(
                AuthServices.getUid, 'ההזמנה בהכנה'),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: myColors.buttonColor,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot order = snapshot.data!.docs[index];
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.4,
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'הזמנה בהכנה',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                'שם הלקוח: ${order['consumerName']}',
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                'טלפון הלקוח: ${order['consumerPhoneNumber']}',
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                'כתובת הלקוח: ${order['consumerAddress']}',
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                'סטטוס הזמנה: ${order['orderStatus']}',
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                'כמות מוצרים: ${order['totalAmount']}',
                                textAlign: TextAlign.right,
                              ),
                              Text(
                                'הערות: ${order['remarks']}',
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  order['deliveryOrCollction']
                                      ? const Icon(Icons
                                          .delivery_dining) // Delivery icon
                                      : const Icon(Icons.shopping_bag),
                                  const Text(
                                    'סוג משלוח: ',
                                    textAlign: TextAlign.right,
                                    textDirection: TextDirection.rtl,
                                  ),
                                  // order time
                                  // Collection icon
                                ],
                              ),
                              Text(
                                'סוג תשלום: ${order['cashOrCredit'] ? 'אשראי' : 'מזומן'}',
                                textAlign: TextAlign.right,
                              ),
                              order['orderTime'] != null
                                  ? Text(
                                      'שעת ביצוע הזמנה: ${order['orderTime'].toDate().toString().substring(0, 16)}',
                                      textAlign: TextAlign.right,
                                    )
                                  : const SizedBox(),

                              // * Display the shipping details
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                padding: const EdgeInsets.all(
                                    10.0), // Add some padding
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xC8F4AE5C,
                                  ), // Set the color to yellow
                                  borderRadius: BorderRadius.circular(
                                      10.0), // Make it slightly rounded
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: order['shipping'] != null
                                      ? List.generate(
                                          (order['shipping'] as List)
                                              .whereType<Map<String, dynamic>>()
                                              .length,
                                          (index) {
                                            Map<String, dynamic> shippingMap =
                                                (order['shipping'] as List)
                                                    .whereType<
                                                        Map<String, dynamic>>()
                                                    .toList()[index];
                                            Shipping shippingItem =
                                                Shipping.fromMap(shippingMap);
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'שם מוצר: ${shippingItem.items.name}',
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                                Text(
                                                  'כמות: ${shippingItem.amount}',
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                                shippingItem.comments
                                                            .isNotEmpty &&
                                                        shippingItem.comments
                                                            .isNotEmpty &&
                                                        !shippingItem.comments
                                                            .contains(
                                                          'rake',
                                                        )
                                                    ? Text(
                                                        'שינויים במנה : בלי ${shippingItem.comments.join(' without ')}',
                                                        textAlign:
                                                            TextAlign.right,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                      )
                                                    : const SizedBox
                                                        .shrink(), // Empty widget when there are no changes or changes are "rake"
                                                Text(
                                                  'מחיר: ${shippingItem.price}',
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      : [], // Return an empty list if 'shipping' is null
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'סכום כולל: ${order['totalPirce']}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              const SizedBox(height: 10),

                              // * Display the buttons
                              Center(
                                child: MyButton(
                                    color: Colors.green,
                                    text: 'סופקה',
                                    horizontal: 20.0,
                                    vertical: 10.0,
                                    onTap: () {
                                      OrderServices.updateOrderStatus(order.id,
                                          {'orderStatus': 'ההזמנה סופקה'});
                                    }),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
