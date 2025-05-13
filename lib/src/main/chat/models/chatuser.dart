class ChatUser {
  ChatUser(
      {required this.senderkey,
      required this.recieverkey,
      required this.senderimage,
      required this.roomid});

  String senderkey;
  String recieverkey;
  String senderimage;
  String? recieverimage;
  String roomid;
}
