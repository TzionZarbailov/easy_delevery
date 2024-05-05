import 'package:easy_delevery/colors/my_colors.dart';
import 'package:easy_delevery/components/my_textfield.dart';
import 'package:easy_delevery/services/auth_services.dart';
import 'package:easy_delevery/services/user_services.dart';
import 'package:flutter/material.dart';

class MyPersonalDetails extends StatefulWidget {
  const MyPersonalDetails({super.key});

  @override
  State<MyPersonalDetails> createState() => _MyPersonalDetailsState();
}

TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController phoneController = TextEditingController();

class _MyPersonalDetailsState extends State<MyPersonalDetails> {
  //* dispose the controllers
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(65.0), // Provide the height of the AppBar.
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                myColors.buttonColor.withOpacity(0.25),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text(
              'פרטים אישיים',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 125),
            child: Column(
              children: [
                MyTextField(
                  keyboardType: TextInputType.name,
                  labelText: 'שם מלא',
                  obscureText: false,
                  controller: nameController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                MyTextField(
                  keyboardType: TextInputType.emailAddress,
                  labelText: 'אימייל',
                  obscureText: false,
                  controller: emailController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                MyTextField(
                  keyboardType: TextInputType.phone,
                  labelText: 'טלפון',
                  obscureText: false,
                  controller: phoneController,
                ),
              ],
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.greenAccent,
                  content: Text(
                    'הפרטים נשמרו בהצלחה',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  duration: Duration(seconds: 2),
                ),
              );

              await UserServices.updateUser(AuthServices.getUid, {
                'fullName': nameController.text,
                'email': emailController.text,
                'phoneNumber': phoneController.text,
              });
              // Show a SnackBar with a success message
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF8E3CA),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.3,
                vertical: MediaQuery.of(context).size.height * 0.02,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'עדכן פרטים',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
