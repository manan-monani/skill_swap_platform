import 'package:flutter/material.dart';

// A custom button widget for the skill_swap_platform application.
class CustomButton extends StatelessWidget {
  // The text to be displayed on the button.
  final String text;
  // The callback function to be executed when the button is pressed.
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
