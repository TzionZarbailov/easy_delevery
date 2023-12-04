import 'package:easy_delevery/colors/my_colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final TextInputType keyboardType;

  const MyTextField({
    super.key,
    required this.keyboardType,
    required this.labelText,
    required this.obscureText,
    required this.controller,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 45,
      ),
      child: TextField(
        keyboardType: keyboardType,
        textAlign: TextAlign.center,
        obscureText: obscureText,
        controller: controller,
        cursorColor: Colors.white,
        style: const TextStyle(
          color: myColors.textColor,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: myColors.inputColor,
          enabledBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
            borderSide: BorderSide(
              width: 1,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                labelText,
                style: const TextStyle(
                  color: myColors.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          prefixIcon: prefixIcon,
          prefixIconColor: myColors.greyColor,
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
