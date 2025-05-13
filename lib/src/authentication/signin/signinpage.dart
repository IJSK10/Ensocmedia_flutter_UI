// ignore_for_file: file_names

import "package:flutter/material.dart";
import 'package:project/src/authentication/signin/secretkeypages/secretKeyPage.dart';
import 'package:project/src/authentication/signin/secretkeypageview.dart';
import 'package:project/src/widgets/lineor.dart';
import 'package:project/src/widgets/button.dart';
import 'package:project/src/widgets/formfield.dart';
import "package:responsive_sizer/responsive_sizer.dart";

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final passwordController = TextEditingController();

    void createAccountfunction() {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SecretKeyPageView(
                    name: nameController.text,
                  )));
    }

    void loginaccountbutton() {
      Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
    }

    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80.h,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: Column(children: [
                SizedBox(height: 1.5.h),
                Text(
                  "Create an Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20.sp),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: EdgeInsets.only(left: 3.h, right: 4.h, bottom: 1.h),
                  child: CustomTextForm(
                      controller: nameController,
                      icon: const Icon(Icons.person),
                      text: "Name"),
                ),
                SizedBox(height: 0.5.h),
                Padding(
                  padding: EdgeInsets.only(left: 3.h, right: 4.h, bottom: 3.h),
                  child: CustomTextForm(
                      controller: passwordController,
                      icon: const Icon(Icons.key_rounded),
                      text: "Password"),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Button(
                    buttonfunction: createAccountfunction,
                    text: "Create a new Account"),
                SizedBox(
                  height: 1.h,
                )
              ]),
            ),
            SizedBox(
              height: 2.5.h,
            ),
            const Lineor(),
            SizedBox(
              height: 2.5.h,
            ),
            Button(
                buttonfunction: loginaccountbutton,
                text: "Already have a wallet"),
          ],
        ),
      ),
    );
  }
}
