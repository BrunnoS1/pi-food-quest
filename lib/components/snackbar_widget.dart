import 'package:flutter/material.dart';

class SnackbarUtil {
  static void showSnackbar(BuildContext context, String message, {bool isError = false}) {
    final snackBar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            isError ? Icons.error_outline : Icons.check_circle_outline_rounded,
            color: Colors.black,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(message, style: const TextStyle(color: Colors.black, fontSize: 18),),
        ],
      ),
      backgroundColor: isError ? Colors.red[400] : const Color.fromARGB(255, 255, 215, 90),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
