import 'package:easy_delevery/components/my_button.dart';
import 'package:flutter/material.dart';

enum ResetMethod { email, mobile }

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();
  ResetMethod? resetMethod;

  //* Register function
  void _reset() {}

  void get _emailReset => setState(() {
        resetMethod = ResetMethod.email;
      });

  void get _mobileReset => setState(() {
        resetMethod = ResetMethod.mobile;
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
                  children: <Widget>[
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
                    if (resetMethod == ResetMethod.email)
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        controller: emailController,
                        cursorColor: const Color(0xFFF98F13),
                        decoration: InputDecoration(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'דוא"ר',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange.shade300),
                          ),
                        ),
                      ),
                    if (resetMethod == ResetMethod.mobile)
                      TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        controller: phoneNumController,
                        cursorColor: const Color(0xFFF98F13),
                        decoration: InputDecoration(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'מספר טלפון',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          border: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.orange.shade300),
                          ),
                        ),
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
