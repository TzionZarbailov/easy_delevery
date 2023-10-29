import 'package:easy_delevery/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/my_textfield.dart';
import 'package:easy_delevery/components/text_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //* text controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //* get image from assets folder
              Stack(
                children: [
                  Container(
                    width: 425,
                    height: 520,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/imageLogin.jpeg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      width: 430,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0x00181A26),
                            Color.fromARGB(217, 0, 0, 0),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 20,
                        ),
                        child: Text(
                          '!ברוכים השבים',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Hind Vadodara',
                            fontWeight: FontWeight.w600,
                            height: 0.03,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              //* text field for email
              MyTextField(
                labelText: ':דוא"ל',
                obscureText: false,
                controller: emailController,
              ),

              const SizedBox(height: 10),
              //* text field for password
              MyTextField(
                labelText: ':סיסמא',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 5),
              //*password recovery
              const TextHomeScreen(text: '?שכחת סיסמא'),

              const SizedBox(height: 5),

              MyButton(
                text: 'התחבר',
                horizontal: 22,
                vertical: 5,
                selectedPage: () {},
              ),

              const SizedBox(height: 3),

              const TextHomeScreen(text: 'או התחבר עם'),
              //* Icon google
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //* Icon facebook
                  IconButton(
                    focusColor: Colors.white,
                    iconSize: 33,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.facebook,
                      color: Color(0xFF345FF6),
                    ),
                  ),
                  //* Icon google
                  IconButton(
                    focusColor: Colors.white,
                    onPressed: () {},
                    icon: Image.asset(
                      'lib/assets/images/google-logo.png',
                      width: 33,
                      height: 33,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              //* text field for registration
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'גלול הצידה',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Mukta Mahee',
                      fontWeight: FontWeight.w700,
                      height: 0.07,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'להרשמה',
                    style: TextStyle(
                      color: Color(0xFFF98F13),
                      fontSize: 20,
                      fontFamily: 'Mukta Mahee',
                      fontWeight: FontWeight.w700,
                      height: 0.07,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
