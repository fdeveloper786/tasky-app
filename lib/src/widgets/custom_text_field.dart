import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        errorText: errorText,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
