import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/src/widgets/button.dart';
import 'package:project/src/widgets/formfield.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:project/src/states/login.dart';
import 'package:project/src/widgets/lineor.dart';

class Loginpage extends ConsumerWidget {
  Loginpage({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void loginbuttonfunction() {
      ref.read(loginProvider.notifier).turnlogin();
    }

    void newaccountfunction() {
      Navigator.pushNamedAndRemoveUntil(context, '/Signin', (route) => false);
    }

    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Log in to Chatbox",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18.5.sp,
                fontWeight: FontWeight.w900),
          ),
          SizedBox(height: 2.8.h),
          Container(
            width: 80.h,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(1.25.h),
                  child: Text(
                      "Welcome back! Sign in using your social account or email to continue us",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 17.sp)),
                ),
                SizedBox(height: 0.5.h),
                Padding(
                  padding: EdgeInsets.only(left: 3.h, right: 4.h, bottom: 1.h),
                  child: CustomTextForm(
                      controller: namecontroller,
                      icon: const Icon(Icons.person),
                      text: "Name"),
                ),
                SizedBox(height: 0.5.h),
                Padding(
                  padding: EdgeInsets.only(left: 3.h, right: 4.h, bottom: 3.h),
                  child: CustomTextForm(
                      controller: passcontroller,
                      icon: const Icon(Icons.key_rounded),
                      text: "Password"),
                ),
                Button(
                    buttonfunction: loginbuttonfunction,
                    text: "Click to login"),
                SizedBox(height: 0.5.h),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Forgot Password?",
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = () {})
                  ],
                )),
                SizedBox(height: 1.5.h),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          const Lineor(),
          SizedBox(height: 2.h),
          Button(
              buttonfunction: newaccountfunction, text: "Don't have a wallet")
        ],
      )),
    );
  }
}
/*
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  void _addAccount() {
    setState(() {
      _haveAccount = false;
    });
  }

  void _existAccount() {
    setState(() {
      _haveAccount = true;
    });
  }

  bool _haveAccount = true;
  @override
  Widget build(BuildContext context) {
    return _haveAccount
        ? LogAccountPage(onAddAccount: _addAccount)
        : CreateNewAccountPage(
            onExistAccount: _existAccount,
          );
  }
}*/
