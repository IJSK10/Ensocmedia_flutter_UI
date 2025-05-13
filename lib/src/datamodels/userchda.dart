class Userchda {
  Userchda(
      {required this.reciever,
      required this.cypher,
      required this.datecreated,
      required this.room_id,
      required this.sender});

  String reciever;
  String sender;
  String cypher;
  DateTime datecreated;
  String room_id;

  factory Userchda.fromjson(Map<String, dynamic> json) {
    return Userchda(
        sender: json['sender'],
        cypher: json['cypher'],
        datecreated: DateTime.parse(json['datecreated']),
        reciever: json['reciever'],
        room_id: json['room_id']);
  }

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'reciever': reciever,
        'cypher': cypher,
        'date': datecreated.toString(),
        'room_id': room_id
      };
}
