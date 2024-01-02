import 'package:flutter/material.dart';
import 'package:easy_delevery/services/auth_services.dart';

import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_button.dart';
import 'package:easy_delevery/components/my_textfield.dart';
import 'package:easy_delevery/components/text_home_screen.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;

  const LoginScreen({super.key, required this.showRegisterPage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future signIn(context) async {
    try {
      await AuthServices()
          .signInWithEmailAndPassword(
              _emailController.text, _passwordController.text)
          .then((value) => null);
    } catch (_) {
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            content: const Text(
              '.שם משתמש או סיסמה לא נכונים',
              textAlign: TextAlign.center,
              style: TextStyle(
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
    }
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.backgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  // image
                  Container(
                    width: 425,
                    height: 520,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('lib/assets/images/imageLogin.jpeg'),
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
                        padding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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

                  // registration button
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
                            onTap: widget.showRegisterPage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              // email text field
              MyTextField(
                labelText: ':דוא"ל',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                controller: _emailController,
              ),

              const SizedBox(height: 10),

              // password text field
              MyTextField(
                keyboardType: TextInputType.visiblePassword,
                labelText: ':סיסמה',
                obscureText: _obscureText,
                controller: _passwordController,
                prefixIcon: _passwordController.text.isNotEmpty
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

              // forgot password
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/reset_password'),
                child: const TextHomeScreen(text: '?שכחת סיסמה'),
              ),

              const SizedBox(height: 5),

              // login button
              MyButton(
                text: 'התחבר',
                horizontal: 22,
                vertical: 5,
                onTap: () async {
                  signIn(context);
                },
              ),

              const SizedBox(height: 10),

              // or login with
              const TextHomeScreen(text: 'או התחבר עם'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // facebook icon
                  IconButton(
                    focusColor: Colors.white,
                    iconSize: 50,
                    onPressed: () {}, // Add your Facebook login logic here
                    icon: const Icon(Icons.facebook, color: Color(0xFF345FF6)),
                  ),

                  const SizedBox(width: 15),

                  // google icon
                  IconButton(
                    focusColor: Colors.white,
                    onPressed: () async {
                      await AuthServices().signInWithGoogle();
                    },
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
