import 'package:easy_delevery/screens/login_screen.dart';
import 'package:easy_delevery/screens/sign_up_business_owners.dart';
import 'package:easy_delevery/screens/sign_up_customers.dart';
import 'package:easy_delevery/components/text_home_screen.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:easy_delevery/components/my_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void selectPage(BuildContext context, Widget pageScreen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return pageScreen;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
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
                //* This is the text on the top of the screen'
                TextHomeScreen(text: 'פלטפורמה נוחה ומקוונת להזמנה'),

                //* This is the text on the middle of the screen
                TextHomeScreen(text: 'TAKE AWAY/משלוחים'),

                //* This is the text on the bottom of the screen
                TextHomeScreen(text: 'ממגוון מסעדות ברחבי הארץ'),
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
      ),
    );
  }
}
