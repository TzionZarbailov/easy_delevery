// ignore_for_file: unnecessary_null_comparison

import 'package:easy_delevery/screens/login_screen.dart';
import 'package:easy_delevery/screens/sign_up_business_owners.dart';
import 'package:easy_delevery/screens/sign_up_customers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:easy_delevery/widgets/my_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void selectPage(BuildContext context, Widget pageScreen) {
    if (pageScreen == null) {
      return;
    } else {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => pageScreen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //* Login button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    text: 'התחבר',
                    horizontal: 10,
                    vertical: double.minPositive,
                    selectedPage: () => selectPage(
                      context,
                      //* Sign in Screen
                      const LoginScreen(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 50),

          //* image and Text Easy_delivery
          Stack(
            children: [
              Image.asset(
                'lib/assets/images/hamburgerImage.webp',
                height: 350,
                width: 400,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 10,
                right: 50,
                child: Text(
                  'Easy_Delevery',
                  style: GoogleFonts.abrilFatface(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
          //* List text
          Column(
            children: const <Widget>[
              //* This is the text on the top of the screen
              Text(
                'פלטפורמה נוחה ומקוונת להזמנה',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              //* This is the text on the middle of the screen
              Text(
                'TAKE AWAY/משלוחים',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              //* This is the text on the bottom of the screen
              Text(
                'ממגוון מסעדות ברחבי הארץ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          //* Tow inputText
          MyButton(
            text: 'הרשמה ללקוחות',
            horizontal: 66,
            vertical: 12,
            selectedPage: () => selectPage(
              context,
              //* Sign up for customers
              const SignUpCustomers(),
            ),
          ),

          const SizedBox(height: 25),

          MyButton(
            text: 'הרשמה לבעלי עסקים',
            horizontal: 43,
            vertical: 12,
            selectedPage: () => selectPage(
              context,
              //* Sign up for business owners
              const SignUpBusinessOwners(),
            ),
          ),
        ],
      ),
    );
  }
}
