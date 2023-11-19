import 'package:flutter/material.dart';

import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/helper/helper_function.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/my_textfield.dart';
import 'package:easy_delevery/components/text_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //* text controllers
  final Map<String, TextEditingController> _controllers = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };

  //* password visibility
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _controllers.forEach(
      (key, controller) => controller.addListener(
        () {
          setState(() {});
        },
      ),
    );
  }

  @override
  void dispose() {
    _controllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //* get image from assets folder
              Stack(
                children: [
                  Container(
                    width: 425,
                    height: 520,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'lib/assets/images/imageLogin.jpeg',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      width: 430,
                      decoration: const ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0x00181A26),
                            Color.fromARGB(217, 0, 0, 0),
                          ],
                        ),
                        shape: RoundedRectangleBorder(),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 40,
                          horizontal: 20,
                        ),
                        child: Text(
                          '!ברוכים השבים',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: myColors.textColor,
                            fontSize: 40,
                            fontFamily: 'Hind Vadodara',
                            fontWeight: FontWeight.w600,
                            height: 0.03,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyButton(
                            text: 'להרשמה',
                            horizontal: 10,
                            vertical: double.minPositive,
                            onTap: () => Navigator.pushNamed(
                                context, '/registration_screen'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              //* text field for email
              MyTextField(
                labelText: ':דוא"ל',
                obscureText: false,
                controller: _controllers['email']!,
              ),

              const SizedBox(height: 10),
              //* text field for password
              MyTextField(
                labelText: ':סיסמה',
                obscureText: _obscureText,
                controller: _controllers['password']!,
                prefixIcon: _controllers['password']!.text.isNotEmpty
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
              const SizedBox(height: 5),
              //*password recovery
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/reset_password'),
                child: const TextHomeScreen(text: '?שכחת סיסמה'),
              ),
              const SizedBox(height: 5),

              const MyButton(
                text: 'התחבר',
                horizontal: 22,
                vertical: 5,
                onTap: login,
              ),

              const SizedBox(height: 10),

              const TextHomeScreen(
                text: 'או התחבר עם',
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //* Icon facebook
                  const IconButton(
                    focusColor: Colors.white,
                    iconSize: 50,
                    onPressed: loginWithFacebook,
                    icon: Icon(
                      Icons.facebook,
                      color: Color(0xFF345FF6),
                    ),
                  ),
                  const SizedBox(width: 15),
                  //* Icon google
                  IconButton(
                    focusColor: Colors.white,
                    onPressed: loginWithGoogle,
                    icon: Image.asset(
                      'lib/assets/images/google-logo.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
