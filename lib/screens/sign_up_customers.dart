import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/second_text_field.dart';
import 'package:easy_delevery/components/text_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpCustomers extends StatefulWidget {
  const SignUpCustomers({super.key});

  @override
  State<SignUpCustomers> createState() => _SignUpCustomersState();
}

void dispose() {
  _SignUpCustomersState()._nameController.dispose();
  _SignUpCustomersState()._cityController.dispose();
  _SignUpCustomersState()._addresController.dispose();
  _SignUpCustomersState()._floorController.dispose();
  _SignUpCustomersState()._apartmentController.dispose();
  _SignUpCustomersState()._phoneController.dispose();
  _SignUpCustomersState()._emailController.dispose();
  _SignUpCustomersState()._passwordController.dispose();
}

class _SignUpCustomersState extends State<SignUpCustomers> {
//* text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addresController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  final TextEditingController _apartmentController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //* password visibility
  bool _obscureText = true;

  //* init state
  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  //* dispose state
  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _apartmentController.dispose();
    _floorController.dispose();
    _addresController.dispose();
    _cityController.dispose();
    _nameController.dispose();
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
                  height: height / 2.4,
                  width: width,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 150, right: 25),
                      child: SecondTextField(
                        onTap: () {},
                        keyboardType: TextInputType.name,
                        controller: _nameController,
                        labelText: 'שם מלא',
                        obscureText: false,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SecondTextField(
                              onTap: () {},
                              keyboardType: TextInputType.number,
                              controller: _apartmentController,
                              labelText: 'דירה',
                              obscureText: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SecondTextField(
                              onTap: () {},
                              keyboardType: TextInputType.number,
                              controller: _floorController,
                              labelText: 'קומה',
                              obscureText: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 3,
                          child: SecondTextField(
                            onTap: () {},
                            keyboardType: TextInputType.streetAddress,
                            controller: _addresController,
                            labelText: 'כתובת',
                            obscureText: false,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              right: 25,
                            ),
                            child: SecondTextField(
                              onTap: () {},
                              keyboardType: TextInputType.text,
                              controller: _cityController,
                              labelText: 'ישוב',
                              obscureText: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150, right: 25),
                      child: SecondTextField(
                        onTap: () {},
                        keyboardType: TextInputType.number,
                        controller: _phoneController,
                        labelText: 'טלפון',
                        obscureText: false,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150, right: 25),
                      child: SecondTextField(
                        onTap: () {},
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        labelText: 'דוא"ל',
                        obscureText: false,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 200, right: 25),
                            child: SecondTextField(
                              onTap: () {},
                              keyboardType: TextInputType.text,
                              controller: _passwordController,
                              labelText: 'סיסמא',
                              obscureText: _obscureText,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: _passwordController.text.isNotEmpty
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
