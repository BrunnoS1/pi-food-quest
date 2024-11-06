import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                   borderRadius: BorderRadius.all(Radius.circular(16))
                ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                 borderRadius: BorderRadius.all(Radius.circular(16))
              ),
              fillColor: Colors.grey.shade200,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[500]))),
    );
  }
}
