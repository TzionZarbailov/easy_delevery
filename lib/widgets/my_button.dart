import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.horizontal,
    required this.vertical,
    required this.selectedPage,
  });

  final String text;
  final double horizontal;
  final double vertical;
  final void Function() selectedPage;

  

  ButtonStyle _textButtonStyle() {
    return TextButton.styleFrom(
      backgroundColor: Colors.orange.shade700,
      foregroundColor: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: horizontal,
        vertical: vertical,
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: _textButtonStyle(),
      onPressed: selectedPage,
      child: Text(
        text,
        style: _textStyle(),
      ),
    );
  }
}
