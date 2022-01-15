import 'package:flutter/material.dart';

class CustomEmailField extends StatelessWidget {
  const CustomEmailField({
    Key? key,
    required this.emailController,
    required this.validator,
    required this.label,
  }) : super(key: key);

  final TextEditingController emailController;
  final String? Function(String?)? validator;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: const TextStyle(color: Colors.grey),
        cursorColor: Colors.grey,
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        validator: validator,
        decoration:  InputDecoration(
          prefixIcon: const Icon(
            Icons.email,
            color: Colors.blue,
          ),
          labelText: label,
        ));
  }
}
