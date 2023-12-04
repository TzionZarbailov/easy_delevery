import 'package:easy_delevery/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

import 'package:easy_delevery/screens/restaurant_home_screen.dart';
import 'package:easy_delevery/screens/consumer_home_screen.dart';
import 'package:easy_delevery/screens/reset_password.dart';
import 'package:easy_delevery/screens/sign_up_business_owners.dart';
import 'package:easy_delevery/screens/sign_up_customers.dart';

//firebasecrudtute
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {});

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      title: 'Easy_Delevery',
      home: const MainScreen(),
      routes: {
        '/reset_password': (context) => const ResetPassword(),
        '/sign_up_business_owners': (context) => const SignUpBusinessOwners(),
        '/sign_up_customers': (context) => const SignUpCustomers(),
        '/restaurant_home_screen': (context) => const RestaurantHomeScreen(),
        '/consumer_home_screen': (context) => const ConsumerHomeScreen(),
      },
    );
  }
}
