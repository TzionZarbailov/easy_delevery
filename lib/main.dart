import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:easy_delevery/screens/business_owner_home_screen.dart';
import 'package:easy_delevery/screens/consumer_home_screen.dart';
import 'package:easy_delevery/screens/login_screen.dart';
import 'package:easy_delevery/screens/registration_screen.dart';
import 'package:easy_delevery/screens/reset_password.dart';
import 'package:easy_delevery/screens/sign_up_business_owners.dart';
import 'package:easy_delevery/screens/sign_up_customers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: 'Easy_Delevery',
      home: const LoginScreen(),
      routes: {
        '/login_screen': (context) => const LoginScreen(),
        '/registration_screen': (context) => const RegistrationScreen(),
        '/reset_password': (context) => const ResetPassword(),
        '/sign_up_business_owners': (context) => const SignUpBusinessOwners(),
        '/sign_up_customers': (context) => const SignUpCustomers(),
        '/business_owner_home_screen': (context) =>
            const BusinessOwnerHomeScreen(),
        '/consumer_home_screen': (context) => const ConsumerHomeScreen(),
      },
    );
  }
}
