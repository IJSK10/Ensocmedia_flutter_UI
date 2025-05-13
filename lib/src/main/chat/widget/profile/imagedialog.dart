import 'package:flutter/material.dart';
import 'package:project/src/main/chat/models/chatuser.dart';
import 'package:project/src/main/chat/screens/userchatpage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> imageDialog(BuildContext context, ChatUser user) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        //buttonPadding: EdgeInsets.all(0),
        //iconPadding: EdgeInsets.all(0),
        //insetPadding: EdgeInsets.all(0),
        //actionsPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        content: Builder(
          builder: (context) {
            return Container(
              height: 40.h,
              width: 70.w,
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      fit: BoxFit.fill,
                      user.senderimage,
                      width: 70.w,
                      height: 30.h,
                    ),
                    SizedBox(height: 2.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 35.w,
                          height: 5.h,
                          child: IconButton(
                              alignment: Alignment.center,
                              onPressed: () {},
                              icon: const Icon(Icons.info)),
                        ),
                        SizedBox(
                          width: 35.w,
                          height: 5.h,
                          child: IconButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserChatPage(
                                            roomid: user.roomid,
                                            pubkey: user.senderkey)));
                              },
                              icon: const Icon(Icons.message)),
                        )
                      ],
                    )
                  ]),
            );
          },
        ),
      );
    },
  );
}
