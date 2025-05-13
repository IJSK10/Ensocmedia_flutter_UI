// ignore: file_names
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:project/src/authentication/login/loginapicall.dart';
import 'package:project/src/widgets/lineor.dart';
import 'package:project/src/widgets/button.dart';
import 'package:project/src/widgets/formfield.dart';
import 'package:project/src/states/login.dart';

class LogAccountPage extends ConsumerWidget {
  const LogAccountPage({super.key, required this.onAddAccount});
  final void Function() onAddAccount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _namecontroller = TextEditingController();
    void loginbuttonfunction() {
      /*String status = await ref.read(asyncLoginProvider.notifier).loginUser();
      print("Status code $status");
      if (status == "200") {
        ref.read(loginProvider.notifier).turnlogin();
      }*/

      print(ref.read(loginprovider.state).state);
    }

    return Material(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Log in to Chatbox",
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 27),
          const Text(
            "Welcome back! Sign in using your social account or email to continue us",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.none,
                fontSize: 15),
          ),
          const SizedBox(height: 27),
          Ink(
            decoration: const ShapeDecoration(
                shape: CircleBorder(), color: Colors.black26),
            child: IconButton(
                onPressed: () {}, icon: const Icon(Icons.g_mobiledata_rounded)),
          ),
          const SizedBox(height: 27),
          const Lineor(),
          const SizedBox(height: 27),
          CustomTextForm(
              controller: _namecontroller,
              icon: const Icon(Icons.person),
              text: "Name"),
          /*TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.person), labelText: "Name"),
            controller: _namecontroller,
          ),*/
          const SizedBox(height: 27),
          TextFormField(
            decoration: const InputDecoration(
                icon: Icon(Icons.key_rounded), labelText: "Password"),
          ),
          const SizedBox(height: 27),
          Button(buttonfunction: loginbuttonfunction, text: "Click to login"),
          const SizedBox(height: 10),
          RichText(
              text: TextSpan(
            children: [
              TextSpan(
                  text: "Forgot Password?",
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()..onTap = () {})
            ],
          )),
          const SizedBox(height: 27),
          const Lineor(),
          const SizedBox(height: 17),
          Button(buttonfunction: onAddAccount, text: "Don't Have a Wallet"),
        ],
      )),
    );
  }
}
