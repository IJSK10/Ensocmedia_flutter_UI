import 'package:flutter/material.dart';
import 'package:project/src/main/chat/widget/chatmessagewidget.dart';
import 'package:project/src/main/chat/widget/newmessage.dart';

class UserChatPage extends StatelessWidget {
  const UserChatPage({
    super.key,
    required this.roomid,
    required this.pubkey,
  });
  final String roomid;
  final String pubkey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(roomid)),
      body: Column(
        children: [
          Expanded(child: Chatmessage(roomid: roomid)),
          Newmessage(
            pubkey: pubkey,
          )
        ],
      ),
    );
  }
}
