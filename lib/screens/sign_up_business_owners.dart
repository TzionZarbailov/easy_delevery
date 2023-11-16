import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/second_text_field.dart';
import 'package:easy_delevery/components/text_home_screen.dart';

class SignUpBusinessOwners extends StatefulWidget {
  const SignUpBusinessOwners({super.key});

  @override
  State<SignUpBusinessOwners> createState() => _SignUpBusinessOwnersState();
}

class _SignUpBusinessOwnersState extends State<SignUpBusinessOwners> {
  //* text controllers
  Map<String, TextEditingController> controllers = {
    'email': TextEditingController(),
    'name': TextEditingController(),
    'phone': TextEditingController(),
    'restaurantPhone': TextEditingController(),
    'password': TextEditingController(),
    'restaurantName': TextEditingController(),
    'street': TextEditingController(),
    'time': TextEditingController(),
  };

  //* password visibility
  bool _obscureText = true;

  //* init state
  @override
  void initState() {
    super.initState();
    controllers['password']?.addListener(() {
      setState(() {});
    });
  }

  //* dispose state
  @override
  void dispose() {
    controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //* height: MediaQuery.of(context).size.height,
    double height = MediaQuery.of(context).size.height;

    //* width: MediaQuery.of(context).size.width,
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                //* image customer_registration
                Image.asset(
                  'lib/assets/images/business_registration_image.jpeg',
                  height: height / 1.6,
                  width: width,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              'ברוכים הבאים',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Easy_Delevery',
                              style: GoogleFonts.abrilFatface(
                                color: const Color(0xFFF98F13),
                                fontSize: 40,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 2,
                              ),
                            ),
                            const Text(
                              '-ל',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //* Icon button to go back
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Color(0xFFF98F13),
                            size: 26.5,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: const ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0x00181A26),
                          Color.fromARGB(217, 0, 0, 0),
                        ],
                      ),
                      shape: RoundedRectangleBorder(),
                    ),
                    child: Column(
                      children: const [
                        TextHomeScreen(
                          text: 'Easy_Delevery-הצטרפות ל',
                          fontSize: 20,
                        ),
                        TextHomeScreen(
                          text: 'אפליקצית משלוחי האוכל הגדולה בישראל',
                          fontSize: 20,
                        ),
                        TextHomeScreen(
                          text: 'הצטרפו עכשיו והגדילו את פעילות',
                          fontSize: 20,
                        ),
                        TextHomeScreen(
                          text: 'המשלוחים וההכנסות שלכם',
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: width / 3),
                          child: SecondTextField(
                            onTap: () {},
                            keyboardType: TextInputType.emailAddress,
                            controller: controllers['email']!,
                            labelText: 'דוא"ל',
                            obscureText: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: width / 3),
                          child: SecondTextField(
                            onTap: () {},
                            keyboardType: TextInputType.emailAddress,
                            controller: controllers['password']!,
                            labelText: 'סיסמה',
                            obscureText: _obscureText,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.only(
                                top: 15,
                              ),
                              child: controllers['password']!.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(_obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _obscureText = !_obscureText;
                                        });
                                      })
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: width / 15),
                          child: SecondTextField(
                            onTap: () {},
                            keyboardType: TextInputType.number,
                            controller: controllers['phone']!,
                            labelText: 'טלפון',
                            obscureText: false,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: SecondTextField(
                          onTap: () {},
                          keyboardType: TextInputType.text,
                          controller: controllers['name']!,
                          labelText: 'שם מלא',
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: width / 3),
                          child: SecondTextField(
                            onTap: () {},
                            keyboardType: TextInputType.text,
                            controller: controllers['restaurantName']!,
                            labelText: 'שם המסעדה',
                            obscureText: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: width / 15),
                          child: SecondTextField(
                            onTap: () {},
                            keyboardType: TextInputType.streetAddress,
                            controller: controllers['street']!,
                            labelText: 'עיר',
                            obscureText: false,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: SecondTextField(
                          onTap: () {},
                          keyboardType: TextInputType.number,
                          controller: controllers['restaurantPhone']!,
                          labelText: 'טלפון של מסעדה',
                          obscureText: false,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: width / 2),
                          child: SecondTextField(
                            onTap: () {},
                            keyboardType: TextInputType.datetime,
                            controller: controllers['time']!,
                            labelText: 'שעות פעילות',
                            obscureText: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyButton(
                          text: 'הרשמה',
                          horizontal: 25,
                          vertical: double.minPositive,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
