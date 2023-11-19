import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/second_text_field.dart';
import 'package:easy_delevery/components/text_home_screen.dart';

class SignUpCustomers extends StatefulWidget {
  const SignUpCustomers({super.key});

  @override
  State<SignUpCustomers> createState() => _SignUpCustomersState();
}

class _SignUpCustomersState extends State<SignUpCustomers> {
//* text controllers
  final Map<String, TextEditingController> _controllers = {
    'name': TextEditingController(),
    'city': TextEditingController(),
    'address': TextEditingController(),
    'floor': TextEditingController(),
    'apartment': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  //* password visibility
  bool _obscureText = true;

  //* init state
  @override
  void initState() {
    super.initState();
    _controllers['password']!.addListener(() {
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
    double getHeight(BuildContext context) =>
        MediaQuery.of(context).size.height;

    //* width: MediaQuery.of(context).size.width,
    double getWidth(BuildContext context) => MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //* Icon button to go back
            SafeArea(
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

            //* Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
                      )
                    ],
                  ),
                ],
              ),
            ),

            Stack(
              children: [
                //* image customer_registration
                Image.asset(
                  'lib/assets/images/hamburgerImage.webp',
                  height: getHeight(context) / 2.4,
                  width: getWidth(context),
                  fit: BoxFit.cover,
                ),

                //* Text
                Positioned(
                  bottom: BorderSide.strokeAlignInside,
                  left: BorderSide.strokeAlignCenter,
                  right: BorderSide.strokeAlignCenter,
                  child: Container(
                    height: 50,
                    width: 420,
                    alignment: Alignment.center,
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
                    child: const TextHomeScreen(
                      text: 'להרשמה יש להזין את הפרטים הבאים',
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
            //* TextFields
            Column(
              children: [
                Column(
                  children: [
                    buildTextField(
                      padding: const EdgeInsets.only(left: 150, right: 25),
                      keyboardType: TextInputType.name,
                      controller: _controllers['name']!,
                      labelText: 'שם מלא',
                      onTap: () {},
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: buildTextField(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            keyboardType: TextInputType.number,
                            controller: _controllers['apartment']!,
                            labelText: 'דירה',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: buildTextField(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            keyboardType: TextInputType.number,
                            controller: _controllers['floor']!,
                            labelText: 'קומה',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 3,
                          child: buildTextField(
                            keyboardType: TextInputType.streetAddress,
                            controller: _controllers['address']!,
                            labelText: 'כתובת',
                            onTap: () {},
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 3,
                          child: buildTextField(
                            padding: const EdgeInsets.only(right: 25),
                            controller: _controllers['city']!,
                            labelText: 'ישוב',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    buildTextField(
                      padding: const EdgeInsets.only(left: 150, right: 25),
                      keyboardType: TextInputType.number,
                      controller: _controllers['phone']!,
                      labelText: 'טלפון',
                      onTap: () {},
                    ),
                    buildTextField(
                      padding: const EdgeInsets.only(left: 150, right: 25),
                      keyboardType: TextInputType.emailAddress,
                      controller: _controllers['email']!,
                      labelText: 'דוא"ל',
                      onTap: () {},
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: buildTextField(
                            padding:
                                const EdgeInsets.only(left: 200, right: 25),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
