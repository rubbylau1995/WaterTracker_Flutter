import 'package:flutter/material.dart';

class ElevatedButtonWithTitle extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;

  const ElevatedButtonWithTitle({
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ElevatedButton.styleFrom(
        // primary: Colors.blue,
        // textStyle: TextStyle(fontSize: 18),
        // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}