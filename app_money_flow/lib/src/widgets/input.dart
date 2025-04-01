import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;

  const Input({
    super.key,
    required this.label,
    required this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorText: errorText, // Exibe o erro se houver
      ),
    );
  }
}
