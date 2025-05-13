import 'package:flutter/material.dart';
import "package:responsive_sizer/responsive_sizer.dart";

class Lineor extends StatelessWidget {
  const Lineor({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        SizedBox(width: 10.w),
        const Text("or"),
        SizedBox(width: 10.w),
        const Expanded(child: Divider())
      ],
    );
  }
}
