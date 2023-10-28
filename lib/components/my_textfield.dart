import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.labelText,
    required this.obscureText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 45,
      ),
      child: TextField(
        textAlign: TextAlign.center,
        obscureText: obscureText,
        controller: controller,
        cursorColor: Colors.white,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF98F13),
          enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
            borderSide: BorderSide(
              width: 3,
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
            borderSide: BorderSide(
              width: 3,
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                labelText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.only(
            left: 20,
            bottom: 10,
            top: 10,
            right: 20,
          ),
        ),
      ),
    );
  }
}
