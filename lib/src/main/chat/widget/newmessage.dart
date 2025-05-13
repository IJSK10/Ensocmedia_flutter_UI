import 'package:flutter/material.dart';
import 'package:project/src/datamodels/sendmessage.dart';
import 'package:uuid/uuid.dart';

class Newmessage extends StatefulWidget {
  const Newmessage({super.key, required this.pubkey});
  final String pubkey;
  @override
  State<Newmessage> createState() => _NewmessageState();
}

class _NewmessageState extends State<Newmessage> {
  final uuid = const Uuid();
  final TextEditingController _messageController = TextEditingController();
  void sendmessage() {
    smessages message = smessages(
        uid: uuid.v4(),
        message_type: "text",
        cypher: _messageController.text,
        pubkey: widget.pubkey);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                textCapitalization: TextCapitalization.sentences,
                autocorrect: true,
                enableSuggestions: true,
                decoration: const InputDecoration(labelText: "Send a message"),
              ),
            ),
            IconButton(
                color: Theme.of(context).colorScheme.primary,
                onPressed: sendmessage,
                icon: const Icon(Icons.send)),
          ],
        ));
  }
}
