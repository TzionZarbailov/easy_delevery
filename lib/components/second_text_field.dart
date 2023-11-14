import 'package:easy_delevery/colors/my_colors.dart';
import 'package:flutter/material.dart';

class SecondTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final void Function() onTap;

  const SecondTextField({
    super.key,
    required this.onTap,
    required this.keyboardType,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
      controller: controller,
      cursorColor: myColors.inputColor,
      decoration: InputDecoration(
        label: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              labelText,
              style: const TextStyle(
                color: myColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: myColors.inputColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: myColors.focuseInputColor),
          borderRadius: BorderRadius.circular(8),
        ),
        prefixIcon: prefixIcon,
        prefixIconColor: myColors.greyColor,
      ),
    );
  }
}
