import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.buttonfunction, required this.text});

  final String text;
  final void Function() buttonfunction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: buttonfunction,
        child: Text(text,
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.w600)));
  }
}
