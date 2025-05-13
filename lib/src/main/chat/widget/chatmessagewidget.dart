import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/src/database/db.dart';
import 'package:project/src/datamodels/receivemessages.dart';
import 'package:project/src/main/chat/widget/messagebubble.dart';

class Chatmessage extends ConsumerWidget {
  const Chatmessage({super.key, required this.roomid});
  final String roomid;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Future<List<rmessages>> messages = ChatDatabase.instance.getChat(roomid);
    return FutureBuilder(
      future: ChatDatabase.instance.getChat(roomid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData == false) {
          return const Center(
            child: Text("No messages found"),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong..."),
          );
        }
        final messages = snapshot.data;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
          reverse: true,
          itemCount: messages!.length,
          itemBuilder: (ctx, index) {
            final chatMessage = messages[index];
            final nextChatMessage =
                index + 1 < messages.length ? messages[index + 1] : null;
            final currenMessageUserId = chatMessage.sender;
            final nextMessageUserId =
                nextChatMessage != null ? nextChatMessage.sender : null;
            final nextUserIsSame = nextMessageUserId == currenMessageUserId;

            if (nextUserIsSame) {
              return MessageBubble.next(
                  message: chatMessage.cypher,
                  isMe: "saravana" == currenMessageUserId);
            } else {
              return MessageBubble.first(
                  username: chatMessage.sender,
                  message: chatMessage.cypher,
                  isMe: "saravana" == currenMessageUserId);
            }
          },
        );
      },
    );
  }
}
