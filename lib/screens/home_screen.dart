import 'package:easy_delevery/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:easy_delevery/widgets/my_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _selectPage(BuildContext context, Widget pageScreen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => pageScreen));
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
                    selectedPage: () => _selectPage(
                      context,
                      const SignInScreen(),
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
              Text(
                'פלטפורמה נוחה ומקוונת להזמנה',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'TAKE AWAY/משלוחים',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
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
            selectedPage: () {},
          ),
          const SizedBox(height: 25),
          MyButton(
            text: 'הרשמה לבעלי עסקים',
            horizontal: 43,
            vertical: 12,
            selectedPage: () {},
          ),
        ],
      ),
    );
  }
}
