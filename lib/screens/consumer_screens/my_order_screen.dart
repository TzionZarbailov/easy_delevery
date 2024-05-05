import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/models/shipping.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:easy_delevery/services/order_services.dart';
import 'package:flutter/material.dart';

class MyOrderScreen extends StatefulWidget {
  const MyOrderScreen({super.key});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(65.0), // Provide the height of the AppBar.
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                myColors.buttonColor.withOpacity(0.25),
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
              'ההזמנות שלי',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: OrderServices.getOrderForConsumer(AuthServices.getUid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'אין הזמנות פעילות כרגע',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(
                color: myColors.buttonColor,
              );
            }

            // Sort the documents by orderStatus
            final docs = snapshot.data!.docs;
            docs.sort((a, b) {
              const orderStatusPriority = {
                'ממתין לאישור': 1,
                'ההזמנה בהכנה': 2,
                'ההזמנה סופקה': 3,
                'ההזמנה בוטלה': 4,
              };
              int priorityA = orderStatusPriority[a['orderStatus']] ?? 5;
              int priorityB = orderStatusPriority[b['orderStatus']] ?? 5;
              return priorityA.compareTo(priorityB);
            });
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot order = docs[index];
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
                        Text('מסעדת ${order['resturantName']}',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl),
                        Text(
                          'סטטוס הזמנה: ${order['orderStatus']}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
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
                                ? const Icon(
                                    Icons.delivery_dining) // Delivery icon
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
                          padding:
                              const EdgeInsets.all(10.0), // Add some padding
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
                                              .whereType<Map<String, dynamic>>()
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
                                            textDirection: TextDirection.rtl,
                                          ),
                                          Text(
                                            'כמות: ${shippingItem.amount}',
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          shippingItem.comments.isNotEmpty &&
                                                  shippingItem
                                                      .comments.isNotEmpty &&
                                                  !shippingItem.comments
                                                      .contains(
                                                    'rake',
                                                  )
                                              ? Text(
                                                  'שינויים במנה : בלי ${shippingItem.comments.join(' without ')}',
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                )
                                              : const SizedBox
                                                  .shrink(), // Empty widget when there are no changes or changes are "rake"
                                          Text(
                                            'מחיר: ${shippingItem.price}',
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
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
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
