class rmessages {
  rmessages(
      {required this.uid,
      required this.message_type,
      required this.cypher,
      required this.sender,
      required this.reciever,
      required this.message_id,
      required this.date,
      required this.room_id});
  String uid;
  String message_type;
  String cypher;
  String sender;
  String reciever;
  String message_id;
  DateTime date;
  String room_id;

  factory rmessages.fromjson(Map<String, dynamic> json) {
    return rmessages(
        uid: json['uid'],
        message_type: json['message_type'],
        cypher: json['cypher'],
        sender: json['sender'],
        reciever: json['reciever'],
        message_id: json['message_id'],
        date: DateTime.parse(json['datecreated']),
        room_id: json['room_id']);
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'message_type': message_type,
        'cypher': cypher,
        'sender': sender,
        'reciever': reciever,
        'message_id': message_id,
        'datecreated': date.toIso8601String(),
        'room_id': room_id,
      };
}
/*
class rMessages {
  rMessages(this.uid, this.cypher, this.from);
  String? uid;
  String? cypher;
  String? from;
}*/
