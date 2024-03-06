import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  String hintText;
  bool obscureText;

  MyTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }
}
