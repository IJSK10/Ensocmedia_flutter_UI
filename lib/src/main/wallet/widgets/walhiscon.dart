import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/src/main/wallet/datamodel/wallethistory.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class WalHisCon extends StatelessWidget {
  WalHisCon({super.key, required this.data});
  final Walhistory data;
  final DateFormat dateFormat = DateFormat("yyyy MMMM dd");
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0.6.h),
        //color: Color.fromARGB(255, 7, 7, 7),
        decoration: BoxDecoration(
            color: Color.fromARGB(48, 31, 31, 31),
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(color: Colors.white)),
        child: Row(children: [
          SizedBox(
            width: 2.w,
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 2.25.h,
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmrsqKnpvKfZ-DA8t2fH2zhO15buxy3FahNNr6MTFJaE5xpITwoZrggqc5aqiwD4S2TU8&usqp=CAU"),
            ),
          ),
          SizedBox(width: 3.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(data.name),
              //SizedBox(height: 0.5.h),
              Text(dateFormat.format(data.date)),
            ],
          ),
          Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              data.amount,
              style: TextStyle(color: data.profit ? Colors.green : Colors.red),
            ),
          ),
          SizedBox(
            width: 4.w,
          )
        ]),
      ),
    );
  }
}
