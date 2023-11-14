import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/second_text_field.dart';
import 'package:flutter/material.dart';

enum ResetMethod { email, mobile }

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();
  ResetMethod? _resetMethod;

  //* Register function
  void _reset() {}

  void get _emailReset => setState(() {
        _resetMethod = ResetMethod.email;
        _phoneNumController.clear();
      });

  void get _mobileReset => setState(() {
        _resetMethod = ResetMethod.mobile;
        _emailController.clear();
      });

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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 65,
                color: const Color(0xFFDA7C10),
                child: const Center(
                  child: Text(
                    'אנא מלא את הפרטים הבאים',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.all(35),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFF98F13),
                        ),
                      ),
                      child: const Text(
                        'איפוס סיסמה באמצעות דואר אלקטרוני',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //! Use emailController.text to get the entered email address
                      //! Then, use a service like Firebase Authentication to send a password reset email
                      onPressed: () => _emailReset,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xFFF98F13),
                        ),
                      ),
                      child: const Text(
                        'איפוס סיסמה דרך הנייד',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () => _mobileReset,
                      //! Use phoneNumController.text to get the entered phone number
                      //! Then, use a service like Firebase Authentication to send a password reset SMS
                    ),

                    const SizedBox(height: 25),

                    if (_resetMethod == ResetMethod.email)
                      SecondTextField(
                        onTap: () {},
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        labelText: ':דוא"ל',
                        obscureText: false,
                      ),

                    if (_resetMethod == ResetMethod.mobile)
                      SecondTextField(
                        onTap: () {},
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumController,
                        labelText: ':מספר טלפון',
                        obscureText: false,
                      ),

                    const SizedBox(height: 350),
                    
                    MyButton(
                      text: 'איפוס סיסמה',
                      horizontal: 75,
                      vertical: double.minPositive,
                      fontSize: 15,
                      onTap: () => _reset(),
                      color: const Color(0xFFF98F13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
