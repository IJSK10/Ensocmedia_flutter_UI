import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:intl/intl.dart';
import 'package:project/src/database/db.dart';
import 'package:project/src/datamodels/userchda.dart';
import 'package:project/src/main/chat/models/chatuser.dart';
import 'package:project/src/main/chat/screens/newchat.dart';
import 'package:project/src/main/chat/screens/userchatpage.dart';
import 'package:project/src/main/chat/widget/chatmessagewidget.dart';
import 'package:project/src/datamodels/receivemessages.dart';
import 'package:project/src/datamodels/sendmessage.dart';
import 'package:project/src/main/chat/widget/profile/imagedialog.dart';
import 'package:project/src/widgets/button.dart';
import 'package:project/src/widgets/formfield.dart';
import 'package:project/src/states/socketprovider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final uuid = const Uuid();
  final TextEditingController _messagecontroller = TextEditingController();
  final TextEditingController senderconntroller = TextEditingController();
  final TextEditingController recievercontroller = TextEditingController();
  final TextEditingController roomidcontroller = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    final channel;
    final AsyncValue<List<rmessages>> messages;
    Future<List<Userchda>> usermessages = ChatDatabase.instance.getUsers();
    if (kIsWeb) {
      messages = ref.watch(webmessagesProvider);
      channel = ref.watch(webwsChannelProvider);
    } else {
      messages = ref.watch(messagesProvider);
      channel = ref.watch(wsChannelProvider);
    }
    //final wsurl = Uri.parse('ws://localhost:8080');
    //final channel = WebSocketChannel.connect(wsurl);

    //final channel = IOWebSocketChannel.connect(wsurl);
    //final channel = IOWebSocketChannel.connect('ws://localhost:8080');
    //final Future<List<Userchda>> userchda = ChatDatabase.instance.getUsers();
    void sendmes() {
      print(_messagecontroller.text);
      channel.sink.add(jsonEncode(smessages(
              uid: uuid.v4(),
              message_type: "text",
              cypher: _messagecontroller.text,
              pubkey: "1224")
          .toJson()));
      _messagecontroller.clear();
    }

    void adddata() async {
      print("hello");
      print(await ChatDatabase.instance.getCount());
      rmessages message = rmessages(
          cypher: _messagecontroller.text,
          message_id: uuid.v4(),
          message_type: "text",
          reciever: recievercontroller.text,
          sender: senderconntroller.text,
          uid: uuid.v4(),
          date: DateTime.now(),
          room_id: roomidcontroller.text);
      print(message);
      print("inserted");
      print(await ChatDatabase.instance.getCount());
      await ChatDatabase.instance.insertrmessage(message);
      setState(() {
        usermessages = ChatDatabase.instance.getUsers();
      });
    }

    void refresh() async {
      print(await ChatDatabase.instance.getCount());
      setState(() {
        usermessages = ChatDatabase.instance.getUsers();
      });
    }

    return Container(
      child: Stack(children: [
        Column(children: [
          Expanded(
            child: FutureBuilder(
              future: ChatDatabase.instance.getUsers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.none &&
                    snapshot.hasData == null) {
                  return const Text("No connection");
                } else if (snapshot.hasData == false) {
                  return const Text("No data");
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Userchda userch = snapshot.data![index];
                    return InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 1.5.h),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(width: 1.5, color: Colors.white),
                            ),
                          ),
                          /*decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    style: BorderStyle.solid,
                                    color: Colors.white)),
                          ),*/
                          //borderRadius:
                          //  const BorderRadius.all(Radius.circular(20))),
                          child: Padding(
                              padding: EdgeInsets.all(0.8.h),
                              child: Row(
                                children: [
                                  InkWell(
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "https://i.pinimg.com/236x/a1/02/2a/a1022af39e011bf44273cfbb18d8504c.jpg"),
                                        radius: 3.25.h,
                                      ),
                                      onTap: () => imageDialog(
                                          context,
                                          ChatUser(
                                              senderkey:
                                                  userch.sender == "Saravana"
                                                      ? userch.reciever
                                                      : userch.sender,
                                              recieverkey: "Saravana",
                                              senderimage:
                                                  "https://i.pinimg.com/236x/a1/02/2a/a1022af39e011bf44273cfbb18d8504c.jpg",
                                              roomid: userch.room_id))),
                                  SizedBox(width: 4.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userch.sender == "saravana"
                                            ? userch.reciever
                                            : userch.sender,
                                        style: TextStyle(
                                            fontSize: 17.5.sp,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        userch.cypher,
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Color.fromARGB(
                                              230, 255, 255, 255),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                              /*
                            Column(children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.5),
                                      child: Text(userch.sender),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.5),
                                      child: Text(userch.reciever),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.5),
                                      child: Text(userch.cypher),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.5),
                                      child: Text(
                                          dateFormat.format(userch.datecreated)),
                                    ),
                                  )
                                ],
                              )
                            ]),*/
                              ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserChatPage(
                                      roomid: userch.room_id,
                                      pubkey: userch.sender == "saravana"
                                          ? userch.reciever
                                          : userch.sender,
                                    )));
                      },
                    );
                  },
                );
              },
            ),
          ),
          // Row(
          //   children: [
          //     SizedBox(
          //       height: 40,
          //       width: 23.h,
          //       child: CustomTextForm(
          //           controller: _messagecontroller,
          //           icon: const Icon(Icons.message),
          //           text: "Message"),
          //     ),
          //     SizedBox(
          //       height: 40,
          //       width: 23.h,
          //       child: CustomTextForm(
          //           controller: roomidcontroller,
          //           icon: const Icon(Icons.room_preferences_outlined),
          //           text: "Roomid"),
          //     ),
          //   ],
          // ),
          // Row(
          //   children: [
          //     SizedBox(
          //       height: 40,
          //       width: 23.h,
          //       child: CustomTextForm(
          //           controller: senderconntroller,
          //           icon: const Icon(Icons.person),
          //           text: "sender"),
          //     ),
          //     SizedBox(
          //       height: 40,
          //       width: 23.h,
          //       child: CustomTextForm(
          //           controller: recievercontroller,
          //           icon: const Icon(Icons.person_4_outlined),
          //           text: "reciever"),
          //     )
          //   ],
          // ),
          // Button(buttonfunction: adddata, text: "Add data"),
          // Button(buttonfunction: refresh, text: "refresh")
        ]),
        Align(
            alignment: Alignment.bottomRight,
            heightFactor: 1.27.h,
            widthFactor: 0.78.h,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: IconButton(
                  padding: EdgeInsets.all(1.25.h),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Newchat(),
                        ));
                  },
                  icon: const Icon(
                    Icons.message_rounded,
                    color: Colors.black,
                    size: 30,
                  )),
            ))
      ]),
    );
  }
}
