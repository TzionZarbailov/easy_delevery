import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:easy_delevery/components/text_home_screen.dart';
import 'package:easy_delevery/components/my_button.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //* height: MediaQuery.of(context).size.height,
    double height = MediaQuery.of(context).size.height;

    //* width: MediaQuery.of(context).size.width,
    double width = MediaQuery.of(context).size.width;
    
    //* This is the function that build the button
    Widget buildMyButton(String text, String route) {
      return MyButton(
        text: text,
        horizontal: text == 'הרשמה ללקוחות' ? 66 : 43,
        vertical: 12,
        onTap: () => Navigator.pushNamed(context, route),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            //* Login button
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Color(0xFFF98F13),
                        size: 33,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
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
                  height: height / 2.5,
                  width: width,
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
              children: const [
                //* This is the text on the top of the screen'
                TextHomeScreen(text: 'פלטפורמה נוחה ומקוונת להזמנה'),

                //* This is the text on the middle of the screen
                TextHomeScreen(text: 'TAKE AWAY/משלוחים'),

                //* This is the text on the bottom of the screen
                TextHomeScreen(text: 'ממגוון מסעדות ברחבי הארץ'),
              ],
            ),

            const SizedBox(height: 40),

            //* Sign up for customers
            buildMyButton('הרשמה ללקוחות', '/sign_up_customers'),

            const SizedBox(height: 25),

            //* Sign up for business owners
            buildMyButton('הרשמה לבעלי עסקים', '/sign_up_business_owners'),
          ],
        ),
      ),
    );
  }
}
