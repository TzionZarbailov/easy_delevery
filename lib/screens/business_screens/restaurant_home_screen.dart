// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/shipping.dart';
import 'package:easy_delevery/screens/business_screens/order_history.dart';
import 'package:easy_delevery/screens/business_screens/edit_menu.dart';
import 'package:easy_delevery/services/order_services.dart';
import 'package:easy_delevery/services/restaurant_services.dart';
import 'package:flutter/material.dart';

import 'package:easy_delevery/services/get_firestore/get_restaurant_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_delevery/services/auth_services.dart';

import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_button.dart';

class RestaurantHomeScreen extends StatefulWidget {
  const RestaurantHomeScreen({
    super.key,
  });

  @override
  State<RestaurantHomeScreen> createState() => _RestaurantHomeScreen();
}

class _RestaurantHomeScreen extends State<RestaurantHomeScreen> {
  final userAuth = FirebaseAuth.instance.currentUser!;
  List<String> docID = [];

  getRestaurantName() {
    for (var i = 0; i < docID.length; i++) {
      if (docID[i].isNotEmpty) {
        return GetRestaurantName(documentId: docID[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        endDrawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.6,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          backgroundColor: myColors.inputColor,
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //* GET: Restaurant image and name
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('restaurants')
                          .doc(userAuth.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        //* If the connection is active
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator(
                            color: Colors.orange[400],
                          );

                          //* Snapshot data is has error
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');

                          //* Display error
                        } else {
                          DocumentSnapshot docSnapshot = snapshot.data!;

                          //* If the document does not exist
                          if (!docSnapshot.exists) {
                            return const Text(
                              'לא קיימת מסעדה עם המשתמש הזה',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                          //* If the document exists and contains data as expected then display the data
                          Map<String, dynamic> data =
                              docSnapshot.data() as Map<String, dynamic>;
                          if (!data.containsKey('restaurantImage') ||
                              !data.containsKey('name')) {
                            return const Text('Missing data');
                          }
                          //* Get the restaurant image and name

                          final String restaurantImage = data['restaurantImage']
                                      .toString()
                                      .isEmpty ||
                                  data['restaurantImage'] == null
                              ? 'https://d3m9l0v76dty0.cloudfront.net/system/photos/9533310/original/c33af26ab721782740796a3ef68e6aaa.png' // Default image
                              : data['restaurantImage'];
                          final String restaurantName = data['name'];

                          //* Return the restaurant image and name
                          return Column(
                            children: [
                              //* Restaurant image
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(restaurantImage),
                              ),

                              const SizedBox(height: 10),

                              //* Restaurant name
                              Text(
                                restaurantName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ); // Use snapshot data
                        }
                      },
                    )
                  ],
                ),
              ),

              //* Home screen
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text(
                  'דף הבית',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),

              // * Order history
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text(
                  'היסטורית הזמנות',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const OrderHistory();
                      },
                    ),
                  );
                },
              ),

              // * Edit menu
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(
                  'עריכת תפריט',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return const EditMenu();
                      },
                    ),
                  );
                },
              ),

              // * Sign out
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text(
                  'התנתקות',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                onTap: () async {
                  await AuthServices.signOut();
                },
              ),
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1),
                child: Container(
                  color: myColors.buttonColor,
                  height: 2,
                ),
              ),
              iconTheme: const IconThemeData(
                color: myColors.buttonColor,
              ),
              backgroundColor: Colors.black,
              title: FutureBuilder(
                future: RestaurantServices().getDocId(docID),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: Colors.orange[400],
                    ); // Loading indicator while waiting
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}'); // Display error
                  } else {
                    return getRestaurantName(); // Use snapshot data
                  }
                },
              ),
              centerTitle: true,
            ),
          ],
          body: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: OrderServices.getOrderForRestaurant(userAuth.uid),
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
                                    'הזמנה חדשה',
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: order['shipping'] != null
                                          ? List.generate(
                                              (order['shipping'] as List)
                                                  .whereType<
                                                      Map<String, dynamic>>()
                                                  .length,
                                              (index) {
                                                Map<String, dynamic>
                                                    shippingMap =
                                                    (order['shipping'] as List)
                                                        .whereType<
                                                            Map<String,
                                                                dynamic>>()
                                                        .toList()[index];
                                                Shipping shippingItem =
                                                    Shipping.fromMap(
                                                        shippingMap);
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'שם מוצר: ${shippingItem.items.name}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                    Text(
                                                      'כמות: ${shippingItem.amount}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                    ),
                                                    shippingItem.comments
                                                                .isNotEmpty &&
                                                            shippingItem
                                                                .comments
                                                                .isNotEmpty &&
                                                            !shippingItem
                                                                .comments
                                                                .contains(
                                                              'rake',
                                                            )
                                                        ? Text(
                                                            'שינויים במנה : בלי ${shippingItem.comments.join(' without ')}',
                                                            textAlign:
                                                                TextAlign.right,
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                          )
                                                        : const SizedBox
                                                            .shrink(), // Empty widget when there are no changes or changes are "rake"
                                                    Text(
                                                      'מחיר: ${shippingItem.price}',
                                                      textAlign:
                                                          TextAlign.right,
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // * Button to accept the order
                                      MyButton(
                                        text: 'אשר הזמנה',
                                        color: Colors.green,
                                        horizontal: 25,
                                        vertical: 10,
                                        fontSize: 15,
                                        onTap: () async {
                                          String orderId = order.id;
                                          await OrderServices.updateOrderStatus(
                                            orderId,
                                            {
                                              'orderStatus': 'ההזמנה בהכנה',
                                            },
                                          );
                                        },
                                      ),

                                      //* Button to cancel order
                                      MyButton(
                                        text: 'בטל הזמנה',
                                        color: Colors.red,
                                        horizontal: 25,
                                        vertical: 10,
                                        fontSize: 15,
                                        onTap: () async {
                                          String orderId = order.id;

                                          await OrderServices.updateOrderStatus(
                                            orderId,
                                            {
                                              'orderStatus': 'ההזמנה בוטלה',
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  )
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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // * StreamBuilder to get the isOpen status of the restaurant
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('restaurants')
                            .doc(userAuth.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(
                              color: Colors.orange[400],
                            );
                          }

                          final docSnapshot = snapshot.data!;
                          final data =
                              docSnapshot.data() as Map<String, dynamic>;

                          final bool? isOpen = data['isOpen'];

                          if (isOpen == null) {
                            return const Text('לא קיימים נתונים כאלה');
                          }

                          return MyButton(
                            text: isOpen ? 'סגירת מסעדה ' : 'פתיחת מסעדה',
                            color: isOpen
                                ? Colors.yellow[900]
                                : Colors.yellow[800],
                            horizontal: 25,
                            vertical: 10,
                            fontSize: 15,
                            onTap: () async {
                              await RestaurantServices().updateIsOpen(
                                AuthServices.getUid,
                                !isOpen,
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
