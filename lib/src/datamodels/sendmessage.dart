class smessages {
  smessages(
      {required this.uid,
      required this.message_type,
      required this.cypher,
      required this.pubkey});
  String? uid;
  String? message_type;
  String? cypher;
  String? pubkey;

  factory smessages.fromjson(Map<String, dynamic> json) {
    return smessages(
        uid: json['uid'],
        message_type: json['message_type'],
        cypher: json['cypher'],
        pubkey: json['pubkey']);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'message_type': message_type,
      'cypher': cypher,
      'pubkey': pubkey,
    };
  }
}

class sMessages {
  sMessages(this.cypher, this.pubkey);
  String? cypher;
  String? pubkey;
}
