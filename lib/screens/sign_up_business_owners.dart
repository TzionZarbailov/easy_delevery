import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:easy_delevery/services/auth_service.dart';
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
  final Map<String, TextEditingController> _controllers = {
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
    _controllers['password']?.addListener(() {
      setState(() {});
    });
  }

  //* dispose state
  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
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
                        child: buildTextField(
                          padding: EdgeInsets.only(left: width / 3),
                          keyboardType: TextInputType.emailAddress,
                          controller: _controllers['email']!,
                          labelText: 'דוא"ל',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          padding: EdgeInsets.only(left: width / 3),
                          keyboardType: TextInputType.text,
                          controller: _controllers['password']!,
                          labelText: 'סיסמה',
                          obscureText: _obscureText,
                          onTap: () {},
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                            ),
                            child: _controllers['password']!.text.isNotEmpty
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
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          padding: EdgeInsets.only(left: width / 15),
                          keyboardType: TextInputType.number,
                          controller: _controllers['phone']!,
                          labelText: 'טלפון',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: buildTextField(
                          controller: _controllers['name']!,
                          labelText: 'שם מלא',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          padding: EdgeInsets.only(left: width / 3),
                          controller: _controllers['restaurantName']!,
                          labelText: 'שם המסעדה',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          padding: EdgeInsets.only(left: width / 15),
                          keyboardType: TextInputType.streetAddress,
                          controller: _controllers['street']!,
                          labelText: 'עיר',
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: buildTextField(
                          keyboardType: TextInputType.number,
                          controller: _controllers['restaurantPhone']!,
                          labelText: 'טלפון של מסעדה',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          padding: EdgeInsets.only(left: width / 2),
                          keyboardType: TextInputType.datetime,
                          controller: _controllers['time']!,
                          labelText: 'שעות פעילות',
                          onTap: () {},
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
                          onTap: () async {
                            String autoId = FirebaseFirestore.instance
                                .collection('business')
                                .doc()
                                .id;
                            await AuthService().saveBusinessOwner(
                              BusinessOwner(
                                id: autoId,
                                email: _controllers['email']!.text,
                                password: _controllers['password']!.text,
                                name: _controllers['name']!.text,
                                phoneNumber: _controllers['phone']!.text,
                                businessName: _controllers['restaurantName']!.text,
                                city: _controllers['street']!.text,
                                businessPhone: _controllers['restaurantPhone']!.text,
                                workHours: _controllers['time']!.text,
                              ),
                            );
                          },
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
