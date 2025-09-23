import 'package:flutter/material.dart';

// A custom text field widget for the skill_swap_platform application.
class CustomTextField extends StatelessWidget {
  // The controller for the text field.
  final TextEditingController controller;
  // The label text to be displayed above the text field.
  final String labelText;
  // Whether the text should be obscured (e.g., for passwords).
  final bool obscureText;
  // The maximum number of lines for the text field.
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(labelText: labelText),
    );
  }
}
