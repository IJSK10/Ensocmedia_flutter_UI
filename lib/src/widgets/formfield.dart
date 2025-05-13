import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  const CustomTextForm(
      {super.key,
      required this.controller,
      required this.icon,
      required this.text});
  final TextEditingController controller;
  final Icon icon;
  final String text;

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(icon: widget.icon, hintText: widget.text),
        controller: widget.controller,
        onEditingComplete: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        onChanged: (value) {});
  }
}
