import 'package:flutter/material.dart';
import 'package:project/src/main/wallet/datamodel/currenciesmodel.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

const String ethereum =
    "https://seeklogo.com/images/E/ethereum-eth-logo-CF9DCCA696-seeklogo.com.png";
const String bitcoin =
    "https://upload.wikimedia.org/wikipedia/commons/5/50/Bitcoin.png";

class CurrencyContainer extends StatelessWidget {
  const CurrencyContainer({
    super.key,
    required this.data,
  });
  final curmodel data;
  @override
  Widget build(BuildContext context) {
    final String url = data.name == "Ethereum" ? ethereum : bitcoin;
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
            height: 8.h,
            width: 45.w,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 245, 245),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(2, 7, 5, 5),
                    Color.fromARGB(255, 34, 34, 34)
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: SizedBox(
                          height: 2.5.h,
                          width: 2.5.h,
                          child: CircleAvatar(
                            radius: 2,
                            backgroundImage: NetworkImage(url),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(child: Text(data.name)),
                      Align(
                        alignment: Alignment.topRight,
                        child: data.upprice
                            ? Icon(
                                Icons.arrow_drop_up_sharp,
                                color: Colors.lightGreen,
                              )
                            : Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.red,
                              ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 7.w),
                  child: Text(" ${data.balance} "),
                )
              ],
            )),
      ),
    );
  }
}
