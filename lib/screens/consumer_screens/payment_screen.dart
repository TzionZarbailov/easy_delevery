// ignore_for_file: use_build_context_synchronously

import 'package:easy_delevery/helper/validation_helpers.dart';
import 'package:easy_delevery/models/order.dart';
import 'package:easy_delevery/models/shipping.dart';
import 'package:easy_delevery/screens/consumer_screens/order_confirmation_screen.dart';
import 'package:easy_delevery/screens/consumer_screens/payment_by_credit.dart';

import 'package:easy_delevery/services/auth_services.dart';
import 'package:easy_delevery/services/order_services.dart';
import 'package:easy_delevery/services/restaurant_services.dart';
import 'package:easy_delevery/services/user_services.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final List<Shipping> orders;
  final String restaurantDoc;
  const PaymentScreen({
    Key? key,
    required this.orders,
    required this.restaurantDoc,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  //* deleveryOrCollection is a boolean variable that will be used to determine if the user wants to get the order delivered or if they want to collect it themselves.

  late double postage;

  late double totalPice;
  late String phoneNumber;
  late Widget orderConfirmationScreen;

  List<bool> deleveryOrCollection = [true, false];
  List<bool> cashOrCreditList = [true, false];

  Future<String> getPhoneNumber() async {
    return await UserServices.getUser(
      AuthServices.getUid,
      'phoneNumber',
    );
  }

  final TextEditingController addressController = TextEditingController();
  final TextEditingController floor = TextEditingController();
  final TextEditingController apartmenNumber = TextEditingController();
  final TextEditingController remarks = TextEditingController();

  @override
  void initState() {
    super.initState();
    isDeleveryOrCollection();
    getPhoneNumber().then((value) {
      setState(() {
        phoneNumber = value;
      });
    });
  }

  @override
  void dispose() {
    addressController.dispose();
    floor.dispose();
    apartmenNumber.dispose();
    super.dispose();
  }

  isCashOrCreditList() async {
    String consumerName =
        await UserServices.getUser(AuthServices.getUid, 'fullName');
    String consumerAddress =
        await UserServices.getUser(AuthServices.getUid, 'address');
    String resturantName = await RestaurantServices.getRestaurantName(
        widget.restaurantDoc, 'name');

    Order order = Order(
      consumerId: AuthServices.getUid,
      restaurantId: widget.restaurantDoc,
      resturantName: resturantName,
      consumerName: consumerName,
      consumerAddress: consumerAddress,
      shipping: widget.orders,
      totalAmount: Shipping.getQuantity(widget.orders),
      totalPirce: totalPice,
      remarks: remarks.text,
      consumerPhoneNumber: phoneNumber,
      orderStatus: 'ממתין לאישור',
      deliveryOrCollction: deleveryOrCollection[0],
      cashOrCredit: cashOrCreditList[0],
      orderTime: DateTime.now(),
    );

    if (cashOrCreditList[0] == false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OrderConfirmationScreen(),
        ),
      );
      await OrderServices.addOrder(order.toMap());
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentByCredit(
            order: order,
          ),
        ),
      );
    }
  }

  isDeleveryOrCollection() {
    if (deleveryOrCollection[0] == false) {
      setState(() {
        postage = 0;
        totalPice = Shipping.getPrice(widget.orders) + postage;
      });
    } else {
      setState(() {
        postage = 13;
        totalPice = Shipping.getPrice(widget.orders) + postage;
      });
    }
  }

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
              'סיום הזמנה',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* delivery or collection
            Center(
              child: Container(
                height: 35,
                margin: const EdgeInsets.only(top: 35),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3C793),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: myToggleButtons(
                  deleveryOrCollection,
                  'משלוח',
                  'איסוף',
                  Icons.delivery_dining,
                  Icons.directions_walk,
                  onPressed: isDeleveryOrCollection,
                ),
              ),
            ),
            const SizedBox(height: 25),

            //* Would you like to change address?
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  '?תרצו לשנות את הכתובת',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  height: 42,
                  width: 42,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3C793),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.2,
                    ),
                  ),
                  // * This IconButton will be used to change the address.
                  child: IconButton(
                    highlightColor: Colors.orange[300],
                    onPressed: () {
                      // * This will navigate to the address screen.
                      updateAddress();
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 50),

            // * Messenger requests
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'בקשות לשליח',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.message,
                    color: Colors.black,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // * Registration of requests
            Container(
              height: 200, // Replace with your actual height
              width: MediaQuery.of(context).size.width - 45,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Colors.black,
                    width: 1.2,
                  ),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFF8E3CA),
                    Color(0xC8F4AE5C),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: remarks,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
                    hintText:
                        '... הוספת הערה', // Replace with your actual hint text
                    border: InputBorder.none,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              'תשלום',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),
            // * Credit or cash?
            Center(
              child: Container(
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3C793),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: myToggleButtons(
                  cashOrCreditList,
                  'אשראי',
                  'מזומן',
                  Icons.credit_card,
                  Icons.money,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'כל המחירים ב - ש"ח כולל מע"מ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₪ ${Shipping.getPrice(widget.orders)}',
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const Text(
                        'סכום ההזמנה',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₪ $postage',
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const Text(
                        'דמי משלוח',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '₪ $totalPice',
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      const Text(
                        'סה”כ',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(25),
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
                  padding: const EdgeInsets.symmetric(),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  isCashOrCreditList();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'לחץ לאישור הזמנה ותשלום',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //* This method will return a ToggleButtons widget with two options.
  ToggleButtons myToggleButtons(List<bool> list, String textOne, String textTwo,
      IconData iconOne, IconData iconTwo,
      {Function? onPressed}) {
    return ToggleButtons(
      constraints: const BoxConstraints(
        minHeight: 35,
        minWidth: 150,
      ),
      onPressed: (int index) {
        //* true if delivery, false if collection
        setState(() {
          for (int i = 0; i < deleveryOrCollection.length; i++) {
            list[i] = i == index;
          }
          //* true if cash, false if credit
          setState(() {
            for (int i = 0; i < cashOrCreditList.length; i++) {
              list[i] = i == index;
            }
          });
          //* if onPressed is not null, call onPressed
          if (onPressed != null) {
            onPressed();
          }
        });
      },
      isSelected: list,
      selectedColor: Colors.black,
      splashColor: Colors.orange[300],
      fillColor: const Color(0xFFFF8A00),
      borderRadius: BorderRadius.circular(15),
      children: [
        Row(
          children: [
            Icon(iconOne),
            const SizedBox(width: 5),
            Text(textOne),
          ],
        ),
        Row(
          children: [
            Icon(iconTwo),
            const SizedBox(width: 5),
            Text(textTwo),
          ],
        ),
      ],
    );
  }

  //* update the address in the database
  void updateAddress() async {
    final results = await Future.wait([
      UserServices.getUser(AuthServices.getUid, 'address'),
      UserServices.getUser(AuthServices.getUid, 'floor'),
      UserServices.getUser(AuthServices.getUid, 'apartmenNumber'),
    ]);

    final String addressUser = results[0];
    final String floorUser = results[1];
    final String apartmenNumberUser = results[2];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: const Color(0xFAF4AD5C),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'שינוי כתובת',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'קומה: $floorUser',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'כתובת נוכחית: $addressUser',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Text(
                'דירה: $apartmenNumberUser',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          content: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                onChanged: (value) async {},
                controller: addressController,
                keyboardType: TextInputType.streetAddress,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  hintText: 'הכנס כתובת חדשה',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                  errorStyle: TextStyle(color: Colors.red),
                ),
                validator: (value) {
                  if (ValidationHelper().isValidAddress(value.toString())) {
                    return null;
                  }
                  return 'הכתובת שהוזנה אינה תקינה';
                },
              ),
            ),
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: apartmenNumber,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'הכנס דירה',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        validator: (value) {
                          if (ValidationHelper().isValidFloorNumber(
                            value.toString(),
                          )) {
                            return null;
                          }
                          return 'הכנס דירה תקינה ';
                        },
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        controller: floor,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'הכנס קומה',
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                          errorStyle: TextStyle(color: Colors.red),
                        ),
                        validator: (value) {
                          if (ValidationHelper().isValidFloorNumber(
                            value.toString(),
                          )) {
                            return null;
                          }
                          return 'הכנס קומה תקינה ';
                        },
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  child: const Text(
                    'שמור',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // * Save the address in the database
                  onPressed: () async {
                    if (ValidationHelper()
                            .isValidAddress(addressController.text) &&
                        ValidationHelper().isValidFloorNumber(floor.text) &&
                        ValidationHelper()
                            .isValidFloorNumber(apartmenNumber.text)) {
                      Navigator.pop(context);
                      await UserServices.updateUser(
                        AuthServices.getUid,
                        {
                          'address': addressController.text,
                          'floor': floor.text,
                          'apartmenNumber': apartmenNumber.text,
                        },
                      );
                      // * Clear the text fields
                      for (var controller in [
                        floor,
                        apartmenNumber,
                        addressController
                      ]) {
                        controller.clear();
                      }
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
