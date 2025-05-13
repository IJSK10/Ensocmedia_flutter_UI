import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:project/src/authentication/signin/secretkeypages/secretKeyPage.dart';
import 'package:project/src/authentication/signin/secretkeypages/secretKeyVerificationPage.dart';

class SecretKeyPageView extends StatefulWidget {
  const SecretKeyPageView({super.key, required this.name});
  final String name;
  @override
  State<SecretKeyPageView> createState() => _SecretKeyPageViewState();
}

class _SecretKeyPageViewState extends State<SecretKeyPageView> {
  var mnemonic = Mnemonic.generate(Language.english, entropyLength: 128);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        SecretKeyPage(
          name: widget.name,
          mnemonic: mnemonic,
          pageController: pageController,
        ),
        SecretKeyVerificationPage(
          mnemonic: mnemonic,
          name: widget.name,
          pageController: pageController,
        )
      ],
    );
  }
}
