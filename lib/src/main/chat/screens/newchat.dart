import 'package:flutter/material.dart';
import 'package:project/src/widgets/formfield.dart';
import 'package:project/src/widgets/lineor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Newchat extends StatelessWidget {
  const Newchat({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController namecontroller = TextEditingController();
    TextEditingController publickeycontroller = TextEditingController();
    TextEditingController messagecontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("New chat")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 3.h, right: 4.h, bottom: 2.h),
              child: CustomTextForm(
                  controller: namecontroller,
                  icon: const Icon(Icons.person),
                  text: "Name"),
            ),
            SizedBox(
              height: 2.h,
            ),
            const Lineor(),
            SizedBox(height: 2.h),
            Padding(
              padding: EdgeInsets.only(left: 3.h, right: 4.h, bottom: 2.h),
              child: CustomTextForm(
                  controller: publickeycontroller,
                  icon: const Icon(Icons.key),
                  text: "Public Key"),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 3.h, right: 4.h, bottom: 2.h),
              child: CustomTextForm(
                  controller: messagecontroller,
                  icon: const Icon(Icons.message_rounded),
                  text: "Message"),
            ),
          ],
        ),
      ),
    );
  }
}
