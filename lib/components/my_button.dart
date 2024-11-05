import 'package:flutter/material.dart';

// Usado no login principal

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          width: 300,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(220, 15, 75, 1), borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Text(text,
                style: const TextStyle(
                    color: Color.fromRGBO(255, 215, 90, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          )),
    );
  }
}
