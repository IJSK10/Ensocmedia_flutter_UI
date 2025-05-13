import 'package:flutter/material.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import 'package:project/src/widgets/button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SecretKeyPage extends StatelessWidget {
  const SecretKeyPage(
      {super.key,
      required this.name,
      required this.mnemonic,
      required this.pageController});
  final String name;
  final Mnemonic mnemonic;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    void secretkeybutton() {
      pageController.animateToPage(1,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    var words = mnemonic.words;
    return Scaffold(
      appBar: AppBar(title: const Text("Secret Key")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 2.5.h),
            Text(
              "Secret Phase",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.5.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            SizedBox(
              height: 58.h,
              child: GridView.count(
                childAspectRatio: 7.sp,
                crossAxisSpacing: 5.sp,
                crossAxisCount: 2,
                children: List.generate(
                    words.length,
                    (index) => SizedBox(
                          height: 2.5.h,
                          width: 2.5.h,
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: BeveledRectangleBorder(
                                    borderRadius: BorderRadius.circular(1.5.h),
                                    side: const BorderSide(
                                        color: Color.fromRGBO(220, 174, 150, 1),
                                        style: BorderStyle.solid,
                                        width: 2.5)),
                              ),
                              child: Text(
                                " ${index + 1}. ${words[index]}",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17.5.sp),
                              ),
                              onPressed: () {
                                () {};
                              },
                            ),
                          ),
                        )),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            Button(buttonfunction: secretkeybutton, text: "Create your wallet"),
            SizedBox(height: 5.h)
          ],
        ),
      ),
    );
  }
}
