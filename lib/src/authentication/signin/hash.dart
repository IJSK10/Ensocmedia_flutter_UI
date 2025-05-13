import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:bip39_mnemonic/bip39_mnemonic.dart';
import "package:convert/convert.dart";
import 'package:project/src/datamodels/user.dart';
import 'package:secp256k1/secp256k1.dart';
import 'package:project/src/rust/api/simple.dart';
import 'package:project/src/rust/frb_generated.dart';

class UserDetails {
  String privateKey;
  UserDetails(this.privateKey);
}

Future<User> confirmcreate(Mnemonic mnemonic, String name) async {
  int now = 2;
  print("hello");
  UserKey foo = await UserKey.newUserKey(seed: mnemonic.seed)
      .timeout(Duration(seconds: 10));
  print("private key");
  print(foo.privateKey);
  String hexseed = hex.encode(mnemonic.seed.sublist(0, 32));
  var pk = PrivateKey.fromHex(hexseed);

  var pub = pk.publicKey;
  String abc = now.toString();
  var encode = utf8.encode(abc);
  var hash = sha256.convert(encode);

  var mhash = hash.toString();

  User user =
      User(name: name, sig: "ssd", pubkey: pub.toCompressedHex(), time: now);
  print(user.name);
  return user;
}
