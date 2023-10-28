import 'package:flutter/material.dart';

class TextHomeScreen extends StatelessWidget {
  const TextHomeScreen({
    super.key,
    required this.text,
    this.fontSize = 18,
  });

  final String text;
  final double fontSize;

  TextStyle get _textStyle {
    return TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _textStyle,
    );
  }
}
