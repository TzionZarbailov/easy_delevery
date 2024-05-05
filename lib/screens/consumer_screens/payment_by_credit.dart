import 'package:easy_delevery/models/order.dart';
import 'package:easy_delevery/screens/consumer_screens/order_confirmation_screen.dart';
import 'package:easy_delevery/services/order_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class PaymentByCredit extends StatefulWidget {
  final Order order;

  const PaymentByCredit({
    super.key,
    required this.order,
  });

  @override
  State<PaymentByCredit> createState() => _PaymentByCreditState();
}

class _PaymentByCreditState extends State<PaymentByCredit> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cvv = '';
  String cardHolderName = '';
  bool isCvvFocused = false;

  void userTappedPay() {
    if (formKey.currentState!.validate()) {
      //* only show dialog if form is valid
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color(0xFAF4AD5C),
              title: const Text(
                'אישור תשלום',
                textAlign: TextAlign.end,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      'מספר כרטיס: $cardNumber',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      'תוקף: $expiryDate',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      'שם בעל הכרטיס: $cardHolderName',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                    Text(
                      'CVV: $cvv',
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                    ),
                  ],
                ),
              ),
              actions: [
                //* confirm button
                TextButton(
                  onPressed: () {
                    // * add order to firestore
                    OrderServices.addOrder(widget.order.toMap());
                    // * navigate to order confirmation screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OrderConfirmationScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'אישור',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // * cancel button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'ביטול',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'תשלום באשראי',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //* credit card
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvv,
              showBackView: isCvvFocused,
              onCreditCardWidgetChange: ((p0) {}),
            ),
            //* credit card form
            CreditCardForm(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvv,
              onCreditCardModelChange: ((data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cvv = data.cvvCode;
                  cardHolderName = data.cardHolderName;
                  isCvvFocused = data.isCvvFocused;
                });
              }),
              formKey: formKey,
            ),
            //* pay button
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1),
              child: Container(
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
                      borderRadius: BorderRadius.circular(20), // Add this
                    ),
                  ),
                  onPressed: userTappedPay,
                  child: const Text(
                    'שלם',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
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
