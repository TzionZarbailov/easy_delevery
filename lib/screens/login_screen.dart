import 'package:easy_delevery/screens/reset_password.dart';
import 'package:flutter/material.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //* login functions
  void _login() {}

  void _loginWithGoogle() {}

  void _loginWithFacebook() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                            color: Colors.white,
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
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.3),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white, size: 26.5),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
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
                controller: _emailController,
              ),
            
              const SizedBox(height: 10),
              //* text field for password
              MyTextField(
                labelText: ':סיסמא',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 5),
              //*password recovery
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ResetPassword(),
                  ),
                ),
                child: const TextHomeScreen(text: '?שכחת סיסמה'),
              ),
              const SizedBox(height: 5),

              MyButton(
                text: 'התחבר',
                horizontal: 22,
                vertical: 5,
                onTap: _login,
              ),

              const SizedBox(height: 10),

              const TextHomeScreen(
                text: 'או התחבר עם',
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //* Icon facebook
                  IconButton(
                    focusColor: Colors.white,
                    iconSize: 50,
                    onPressed: _loginWithFacebook,
                    icon: const Icon(
                      Icons.facebook,
                      color: Color(0xFF345FF6),
                    ),
                  ),
                  const SizedBox(width: 15),
                  //* Icon google
                  IconButton(
                    focusColor: Colors.white,
                    onPressed: _loginWithGoogle,
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
