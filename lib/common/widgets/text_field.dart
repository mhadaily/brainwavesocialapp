import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.fieldController,
    required this.fieldValidator,
    required this.label,
    this.obscureText = false,
  });

  final TextEditingController fieldController;
  final String? Function(String?) fieldValidator;
  final String label;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: fieldController,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: fieldValidator,
    );
  }
}
