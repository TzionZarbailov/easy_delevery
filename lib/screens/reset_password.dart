import 'package:easy_delevery/services/user_repository.dart';
import 'package:flutter/material.dart';

import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/second_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumController = TextEditingController();

  final UserRepository _userRepository = UserRepository();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }

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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SecondTextField(
                      onTap: () {},
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      labelText: ':דוא"ל',
                      obscureText: false,
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      text: 'איפוס סיסמה',
                      horizontal: 75,
                      vertical: double.minPositive,
                      fontSize: 15,
                      onTap: () async {
                        if (await _userRepository
                            .checkIfEmailExists(_emailController.text)) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'הסיסמה נשלחה לכתובת הדוא"ל שלך',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.pop(context);
                            _userRepository
                                .resetPasswordWithEmail(_emailController.text);
                          }
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'אנא הכנס כתובת דוא"ל תקינה',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
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
