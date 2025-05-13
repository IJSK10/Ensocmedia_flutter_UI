// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/src/authentication/signin/signinapicall.dart';
import 'package:project/src/datamodels/user.dart';
import 'package:project/src/authentication/signin/hash.dart';
import 'package:project/src/widgets/button.dart';
import 'package:project/src/states/login.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SecretKeyVerificationPage extends ConsumerStatefulWidget {
  const SecretKeyVerificationPage(
      {super.key,
      required this.mnemonic,
      required this.name,
      required this.pageController});
  final Mnemonic mnemonic;
  final String name;
  final PageController pageController;
  @override
  ConsumerState<SecretKeyVerificationPage> createState() =>
      _SecretKeyVerificationPage();
}

class _SecretKeyVerificationPage
    extends ConsumerState<SecretKeyVerificationPage>
    with AutomaticKeepAliveClientMixin {
  bool _keepAlive = true;
  final List<int> w1 = [0, 2, 10];
  final w2 = <int>[3, 8, 11];
  final w3 = <int>[6, 5, 1];
  final w4 = <int>[9, 4, 7];
  final _quiz = [12, 12, 12, 12];
  final _value = [12, 12, 12, 12];
  List<String> words = [];

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Dialog Box'),
            content: const Text(
              'Account Created',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
              ),
            ],
          );
        });
  }

  Widget customRadioButton(String text, int wordno, int index) {
    //print(_value);
    //print(_quiz);
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _value[wordno] = index;
          if (wordno == 0) {
            _quiz[wordno] = w1[index];
          } else if (wordno == 1) {
            _quiz[wordno] = w2[index];
          } else if (wordno == 2) {
            _quiz[wordno] = w3[index];
          } else if (wordno == 3) {
            _quiz[wordno] = w4[index];
          }
        });
      },
      style: OutlinedButton.styleFrom(
        side: BorderSide(
            color: (_value[wordno] == index) ? Colors.white : Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor:
            ((_value[wordno] == index) ? Colors.green : Colors.black),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: (_value[wordno] == index) ? Colors.black : Colors.white),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    w1.shuffle();
    w2.shuffle();
    w3.shuffle();
    w4.shuffle();
    words = widget.mnemonic.words;
    super.initState();
  }

  Future<int> fetchvalue() async {
    await Future.delayed(const Duration(seconds: 15));
    print('Done');
    return Future.value(200);
  }

  void confirmbuttonaccount() async {
    print("called function");
    await ref.read(asyncUserProvider.notifier).loading();
    User user = await confirmcreate(widget.mnemonic, widget.name);
    final _statuscode = await signincall(user);
    await ref.read(asyncUserProvider.notifier).notfinished();
    print("Status code ${_statuscode}");
    if (_statuscode == 200) {
      _keepAlive = false;
      updateKeepAlive();
      _dialogBuilder(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final asyncStatuscode = ref.watch(asyncUserProvider);
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm secret phrase"),
        leading: BackButton(
          onPressed: () {
            widget.pageController.jumpToPage(0);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Please tap on the correct answer of the below seed phrases",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp),
              ),
              SizedBox(
                height: 3.h,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Word #1",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  w1.length,
                  (index) => Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 1.25.w, right: 1.25.w),
                          child:
                              customRadioButton(words[w1[index]], 0, index))),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Word #4",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(
                height: 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  w1.length,
                  (index) => Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 1.25.w, right: 1.25.w),
                          child:
                              customRadioButton(words[w2[index]], 1, index))),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Word #7",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  w1.length,
                  (index) => Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 1.25.w, right: 1.25.w),
                          child:
                              customRadioButton(words[w3[index]], 2, index))),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Word #10",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List.generate(
                  w1.length,
                  (index) => Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(left: 1.25.w, right: 1.25.w),
                          child:
                              customRadioButton(words[w4[index]], 3, index))),
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  switch (asyncStatuscode) {
                    AsyncData() => Button(
                        buttonfunction: confirmbuttonaccount, text: "Confirm"),
                    AsyncError(:final error) => Text('Error $error'),
                    AsyncLoading() =>
                      const Center(child: CircularProgressIndicator()),
                    AsyncValue<int>() => Button(
                        buttonfunction: confirmbuttonaccount, text: "Confirm"),
                  },
                ],
              ),
            ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => _keepAlive;
}
