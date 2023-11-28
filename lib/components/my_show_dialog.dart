import 'package:flutter/material.dart';
import 'package:easy_delevery/colors/my_colors.dart';

class MyShowDialog extends StatelessWidget {
  const MyShowDialog({
    super.key,
    required this.title,
    this.buttonText = 'המשך',
    this.color = Colors.black,
    required this.onPressed,
  });
  final Function() onPressed;
  final String title;
  final String buttonText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: myColors.inputColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
              ),
              child: Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ),
          ],
        ),
      ],
    );
  }
}
