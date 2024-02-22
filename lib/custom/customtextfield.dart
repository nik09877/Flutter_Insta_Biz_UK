import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const CustomTextField(
      {required this.controller,
      required this.hintText,
      required this.labelText,
      required this.icon,
      this.obscureText=false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5)),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          hintText: hintText,
          icon: Icon(icon),

        ),
      ),
    );
  }
}
