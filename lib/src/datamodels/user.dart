//import 'package:secp256k1/secp256k1.dart';

class User {
  User({this.name, this.sig, this.pubkey, this.time});
  String? name;
  String? sig;
  String? pubkey;
  int? time;

  Map<String, dynamic> toJson() => {
        "name": name,
        "signature": sig.toString(),
        "pub_key": pubkey,
        "message": time,
      };
}
