
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  RegisterScreen({super.key});
  //* Register function
  void register() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFFF98F13),
        //* back button
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 26.5,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        title: const Text(
          'שחזור סיסמא',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: Container(
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Container(
              height: 75,
              color: const Color.fromARGB(255, 218, 124, 16),
              child: const Center(
                child: Text('אנא מלא את הפרטים הבאים',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
