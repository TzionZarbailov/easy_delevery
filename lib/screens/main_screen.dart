import 'package:easy_delevery/services/stream_services.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamServices().getStreamHomeScreen(),
    );
  }
}
