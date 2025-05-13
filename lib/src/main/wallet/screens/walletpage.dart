import 'package:flutter/material.dart';
import 'package:project/src/main/wallet/datamodel/wallethistory.dart';
import 'package:project/src/main/wallet/widgets/walhiscon.dart';
import 'package:project/src/main/wallet/widgets/buttoncontainer.dart';
import 'package:project/src/main/wallet/datamodel/currenciesmodel.dart';
import 'package:project/src/main/wallet/widgets/currencycontainer.dart';
import 'package:project/src/widgets/buttonicon.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WalletPage extends StatelessWidget {
  WalletPage({super.key});

  final List<curmodel> list = [
    curmodel(name: "Bitcoin", balance: "\$14524", upprice: true),
    curmodel(name: "Ethereum", balance: "\$2345", upprice: false),
    curmodel(name: "Pi", balance: "\$1.0", upprice: true),
  ];

  final List history = [
    Walhistory(
        name: "Saravana",
        date: DateTime.parse('1969-07-20 20:18:04Z'),
        amount: "- \$432.5",
        icon: "",
        profit: false),
    Walhistory(
        name: "XXX",
        date: DateTime.parse('2023-10-25 05:17:04Z'),
        amount: "+ \$23.1",
        icon: "",
        profit: true),
    Walhistory(
        name: "YYY",
        date: DateTime.parse('2024-07-01 01:15:06Z'),
        amount: "- \$324.7",
        icon: "",
        profit: false),
    Walhistory(
        name: "ZZZ",
        date: DateTime.parse('2025-12-31 20:18:04Z'),
        amount: "+ \$12.7",
        icon: "",
        profit: true),
    Walhistory(
        name: "ZZZ",
        date: DateTime.parse('2025-12-31 20:18:04Z'),
        amount: "+ \$12.7",
        icon: "",
        profit: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            // gradient: const RadialGradient(
            //   center: Alignment.center,
            //   radius: 1.4,
            //   colors: [
            //     Colors.black12,
            //     Color.fromARGB(255, 42, 116, 226),
            //     Colors.black,
            //     // Colors.pink,
            //     Colors.transparent
            //   ],
            // ),
            ),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              height: 18.h,
              width: 80.w,
              margin: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 21, 20, 20),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 42, 116, 226),
                    Colors.pink,
                    Color.fromARGB(255, 118, 203, 97),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 145, 130, 130).withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.w,
                    top: 2.h,
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "BALANCE",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 215, 0),
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 18.sp),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "\$ 1353.67",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 215, 0),
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 18.sp),
                      )),
                ),
                SizedBox(height: 2.75.h),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 9.w),
                      child: ButtonIcon(
                          buttonfunction: () {},
                          icon: const Icon(
                            Icons.send,
                            color: Color.fromARGB(255, 73, 199, 216),
                          ),
                          color: Color.fromARGB(255, 4, 94, 167)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 9.w),
                      child: ButtonIcon(
                          buttonfunction: () {},
                          icon: const Icon(
                            Icons.receipt_long_rounded,
                            color: Color.fromARGB(255, 110, 195, 84),
                          ),
                          color: const Color.fromARGB(255, 3, 109, 6)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 9.w),
                      child: ButtonIcon(
                          buttonfunction: () {},
                          icon: const Icon(
                            Icons.request_quote,
                            color: Colors.red,
                          ),
                          color: Color.fromARGB(255, 151, 2, 2)),
                    ),
                  ],
                )
              ]),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonContainer(
                    buttonfunction: () {},
                    icon: Icon(Icons.upload_rounded),
                    text: "Deposit"),
                SizedBox(width: 8.w),
                ButtonContainer(
                    buttonfunction: () {},
                    icon: Icon(Icons.download_rounded),
                    text: "Withdraw")
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(7.w, 0, 7.w, 0),
              height: 11.5.h,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    list.length,
                    (index) => Card(
                          elevation: 3,
                          child: CurrencyContainer(
                            data: list[index],
                          ),
                        )),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7.w, right: 2.w),
                  child: const Icon(Icons.history),
                ),
                Text("  History"),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(7.w, 0, 7.w, 0),
                //color: Colors.white,
                child: ListView(
                  //reverse: true,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: List.generate(history.length, (index) {
                    int i = history.length - 1 - index;
                    return Padding(
                      padding: EdgeInsets.only(top: 1.h),
                      child: Card(
                          elevation: 3, child: WalHisCon(data: history[i])),
                    );
                  }),
                ),
              ),
            )
          ],
        ));
  }
}
