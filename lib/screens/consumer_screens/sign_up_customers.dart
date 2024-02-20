import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/helper/validation_helpers.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:easy_delevery/services/user_services.dart';
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
    'fullName': TextEditingController(),
    'city': TextEditingController(),
    'address': TextEditingController(),
    'floor': TextEditingController(),
    'apartment': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  Future signUpCustomers() async {
    // Extract controller values
    String email = _controllers['email']!.text;
    String password = _controllers['password']!.text;
    String fullName = _controllers['fullName']!.text;
    String phoneNumber = _controllers['phone']!.text;
    String city = _controllers['city']!.text;
    String address = _controllers['address']!.text;
    String floor = _controllers['floor']!.text;
    String apartmentNumber = _controllers['apartment']!.text;

    // Create new user in auth and firestore
    final List<String> errors = [];

    if (!ValidationHelper().isValidEmail(email) || email.isEmpty) {
      errors.add('.כתובת הדוא"ל אינה תקינה');
    }
    if (!ValidationHelper().isValidPassword(password)) {
      errors
          .add('.הסיסמה חייבת להכיל לפחות 8 תווים, אות גדולה, אות קטנה ומספר');
    }
    if (!ValidationHelper().isValidFullName(fullName)) {
      errors.add('.שם מלא אינו תקין');
    }
    if (!ValidationHelper().isValidPhoneNumber(phoneNumber)) {
      errors.add('.מספר הטלפון אינו תקין');
    }
    if (!ValidationHelper().isValidAddress(address)) {
      errors.add('.כתובת אינה תקינה');
    }
    if (!ValidationHelper().isValidAddress(address)) {
      errors.add('.כתובת אינה תקינה');
    }

    if (errors.isEmpty) {
      // Create new consumer
      final Consumer newConsumer = Consumer(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
        city: city,
        address: address,
        floor: floor,
        apartmentNumber: apartmentNumber,
        role: 'consumer',
      );

      showDialog(
        context: context,
        builder: (context) => Center(
          child: AlertDialog(
            backgroundColor: myColors.inputColor,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '!ההרשמה בוצעה בהצלחה',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/main_screen');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'המשך',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      await AuthServices.registerWithEmailAndPassword(email, password);

      await UserServices().addUserAutoId(newConsumer);

      // Clear text controllers
      _controllers.forEach((_, controller) => controller.clear());
    } else {
      // Show dialog with error messages
      showDialog(
        context: context,
        builder: (context) => Center(
          child: AlertDialog(
            backgroundColor: myColors.inputColor,
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '!שגיאה',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            content: Text(
              errors.join('\n'),
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: const Text(
                      'נסה שוב',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      // Clear text controllers
      _controllers.forEach((_, controller) => controller.clear());
    }
  }

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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                      controller: _controllers['fullName']!,
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
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 3,
                          child: buildTextField(
                            keyboardType: TextInputType.streetAddress,
                            controller: _controllers['address']!,
                            labelText: 'כתובת',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          flex: 3,
                          child: buildTextField(
                            padding: const EdgeInsets.only(right: 25),
                            controller: _controllers['city']!,
                            labelText: 'ישוב',
                          ),
                        ),
                      ],
                    ),
                    buildTextField(
                      padding: const EdgeInsets.only(left: 150, right: 25),
                      keyboardType: TextInputType.number,
                      controller: _controllers['phone']!,
                      labelText: 'טלפון',
                    ),
                    buildTextField(
                      padding: const EdgeInsets.only(left: 150, right: 25),
                      keyboardType: TextInputType.emailAddress,
                      controller: _controllers['email']!,
                      labelText: 'דוא"ל',
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
                            onTap: signUpCustomers,
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
