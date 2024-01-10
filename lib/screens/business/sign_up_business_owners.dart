import 'package:easy_delevery/models/restaurant.dart';
import 'package:easy_delevery/services/restaurant_services.dart';
import 'package:flutter/material.dart';
import 'package:easy_delevery/helper/validation_helpers.dart';
import 'package:easy_delevery/models/user.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:easy_delevery/services/user_services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/second_text_field.dart';
import 'package:easy_delevery/components/text_home_screen.dart';

class SignUpBusinessOwners extends StatefulWidget {
  const SignUpBusinessOwners({super.key});

  @override
  State<SignUpBusinessOwners> createState() => _SignUpBusinessOwnersState();
}

class _SignUpBusinessOwnersState extends State<SignUpBusinessOwners> {
  //* firestore instance

  //* text controllers
  final Map<String, TextEditingController> _controllers = {
    'restaurantId': TextEditingController(),
    'email': TextEditingController(),
    'fullName': TextEditingController(),
    'phone': TextEditingController(),
    'restaurantPhone': TextEditingController(),
    'password': TextEditingController(),
    'restaurantName': TextEditingController(),
    'city': TextEditingController(),
    'address': TextEditingController(),
    'time': TextEditingController(),
  };
  //* add a new business owner to the database

  Future signUpBusinessOwners() async {
    // Extract controller values
    String restaurantId = _controllers['restaurantId']!.text;
    String email = _controllers['email']!.text;
    String password = _controllers['password']!.text;
    String fullName = _controllers['fullName']!.text;
    String phoneNumber = _controllers['phone']!.text;
    String city = _controllers['city']!.text;
    String address = _controllers['address']!.text;
    String businessName = _controllers['restaurantName']!.text;
    String businessPhone = _controllers['restaurantPhone']!.text;
    String workHours = _controllers['time']!.text;

    // Create new user in auth and firestore
    final List<String> errors = [];

    if (!ValidationHelper().isValidEmail(email)) {
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
    if (!ValidationHelper().isValidPhoneNumber(businessPhone)) {
      errors.add('.מספר הטלפון של העסק אינו תקין');
    }
    if (restaurantId.isEmpty) {
      errors.add('.מספר עסק אינו תקין');
    }
    if (businessName.isEmpty) {
      errors.add('.שם המסעדה אינו תקין');
    }
    if (errors.isEmpty && !ValidationHelper().isUserAlreadyExists(email)) {
      errors.add('.המשתמש כבר קיים');
    }
    if (errors.isEmpty && !ValidationHelper().isRestaurantIdAlreadyExists(restaurantId)) {
      errors.add('.העסק כבר קיים');
    }

    if (errors.isEmpty) {
      // Create new business owner
      BusinessOwner newBusinessOwner = BusinessOwner(
        restaurantId: restaurantId,
        fullName: fullName,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        businessName: businessName,
        role: 'businessOwner',
      );

      Restaurant newRestaurant = Restaurant(
        id: restaurantId,
        name: businessName,
        address: address,
        city: city,
        workHours: workHours,
        phoneNumber: businessPhone,
        isOpen: false,
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

      await AuthServices().registerWithEmailAndPassword(email, password);

      await UserServices().addUser(newBusinessOwner);

      await RestaurantServices().addRestaurant(newRestaurant);

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

  // password visibility
  bool _obscureText = true;

  // init state
  @override
  void initState() {
    super.initState();
    _controllers['password']?.addListener(() {
      setState(() {});
    });
  }

  // dispose state
  @override
  void dispose() {
    _controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // height: MediaQuery.of(context).size.height,
    double height = MediaQuery.of(context).size.height;

    // width: MediaQuery.of(context).size.width,
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
                    child: const Column(
                      children: [
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
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: buildTextField(
                          controller: _controllers['fullName']!,
                          labelText: 'שם מלא',
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
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          padding: EdgeInsets.only(left: width / 3),
                          keyboardType: TextInputType.number,
                          controller: _controllers['restaurantId']!,
                          labelText: 'מספר עסק',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: buildTextField(
                          padding: EdgeInsets.only(left: width / 3),
                          keyboardType: TextInputType.number,
                          controller: _controllers['restaurantPhone']!,
                          labelText: 'טלפון של מסעדה',
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
                          controller: _controllers['address']!,
                          labelText: 'כתובת',
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: buildTextField(
                          padding: EdgeInsets.only(left: width / 15),
                          keyboardType: TextInputType.streetAddress,
                          controller: _controllers['city']!,
                          labelText: 'עיר',
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
                          onTap: signUpBusinessOwners,
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
