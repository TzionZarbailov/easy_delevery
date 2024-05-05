import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/screens/consumer_screens/my_order_screen.dart';
import 'package:easy_delevery/screens/main_screen.dart';
import 'package:easy_delevery/services/order_services.dart';
import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({
    super.key,
  });

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: OrderServices.myOrder(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: myColors.buttonColor,
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  //* Check the order status
                  if (snapshot.data!.docs.first['orderStatus'] ==
                      "ממתין לאישור") {
                    return Column(
                      children: [
                        Text(
                          ' סטטוס הזמנה: ${snapshot.data!.docs.first['orderStatus']}',
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: 75, // Set the width
                          height: 75, // Set the height
                          child: CircularProgressIndicator(
                            color: myColors.buttonColor,
                            strokeWidth: 15,
                            strokeCap: StrokeCap.round,
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.data!.docs.first['orderStatus'] ==
                      'ההזמנה בהכנה') {
                    return Column(
                      children: [
                        Text(
                          ' סטטוס הזמנה: ${snapshot.data!.docs.first['orderStatus']}',
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'זמן ההזמנה עד 60 דקות',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                            width: 75, // Set the width
                            height: 75, // Set the height
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 100, // Set the size of the icon
                            ))
                      ],
                    );
                  } else if (snapshot.data!.docs.first['orderStatus'] ==
                      'ההזמנה סופקה') {
                    return Column(
                      children: [
                        Text(
                          ' סטטוס הזמנה: ${snapshot.data!.docs.first['orderStatus']}',
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          width: 75, // Set the width
                          height: 75, // Set the height
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 100, // Set the size of the icon
                          ),
                        )
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Text(
                          ' סטטוס הזמנה: ${snapshot.data!.docs.first['orderStatus']}',
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                            width: 75, // Set the width
                            height: 75, // Set the height
                            child: Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 100, // Set the size of the icon
                            ))
                      ],
                    );
                  }
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(colors: [
                  Color(0xFFF8E3CA),
                  Color(0xC8F4AE5C),
                ]),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.orangeAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyOrderScreen(),
                  ),
                ),
                child: const Text(
                  'לצפייה בהזמנות שלי',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                gradient: LinearGradient(colors: [
                  Color(0xFFF8E3CA),
                  Color(0xC8F4AE5C),
                ]),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.orangeAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Navigate to the main screen
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false,
                  );
                },
                child: const Text(
                  'חזרה למסך הראשי',
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
      ),
    );
  }
}
