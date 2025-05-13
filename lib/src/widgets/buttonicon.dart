import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon(
      {super.key,
      required this.buttonfunction,
      required this.icon,
      required this.color});

  final void Function() buttonfunction;
  final Icon icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: color, // Button color
        child: InkWell(
          //splashColor: Colors.red, // Splash color
          onTap: buttonfunction,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(width: 8.w, height: 8.w, child: icon),
          ),
        ),
      ),
    );
  }
}
