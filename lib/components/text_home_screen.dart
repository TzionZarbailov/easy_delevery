import 'package:flutter/material.dart';

class TextHomeScreen extends StatelessWidget {
  const TextHomeScreen({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.color = Colors.white,
  });

  final String text;
  final double fontSize;
  final Color color;

  TextStyle get _textStyle {
    return TextStyle(
      color: color,
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
