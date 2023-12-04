import 'package:easy_delevery/colors/my_colors.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.horizontal,
    required this.vertical,
    required this.onTap,
    this.fontSize = 20,
    this.color = myColors.buttonColor,
  });

  final String text;
  final double horizontal;
  final double vertical;
  final Function() onTap;
  final double fontSize;
  final Color? color;

  ButtonStyle get _textButtonStyle {
    return TextButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
    );
  }

  TextStyle get _textStyle {
    return TextStyle(
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: _textButtonStyle,
      onPressed: onTap,
      child: Text(
        text,
        style: _textStyle,
      ),
    );
  }
}
