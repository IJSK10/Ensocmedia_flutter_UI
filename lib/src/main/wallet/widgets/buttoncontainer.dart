import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer(
      {super.key,
      required this.buttonfunction,
      required this.icon,
      required this.text});

  final void Function() buttonfunction;
  final Icon icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),
      child: Material(
        color: Color.fromARGB(39, 0, 0, 0),
        child: InkWell(
          onTap: buttonfunction,
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(2, 7, 5, 5),
                    Color.fromARGB(255, 34, 34, 34)
                  ],
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              height: 6.h,
              width: 35.w,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [icon, Text(text)]),
            ),
          ),
        ),
      ),
    );
  }
}
