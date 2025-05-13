import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/src/datamodels/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AsyncLoginNotifier extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    return "abcd";
  }

  Future<String> loginUser() async {
    print("before calling");
    final response = await http.post(
      Uri.https("https://a36b-103-146-175-141.ngrok-free.app/signin"),
      headers: {'Content-type': 'application/json'},
      //body: jsonEncode(user.toJson()),
    ).timeout(const Duration(seconds: 5));
    print(response.body);
    final statuscode = response.statusCode;
    return statuscode.toString();
  }

  Future<void> loading() async {
    state = const AsyncValue.loading();
  }
}

final asyncLoginProvider =
    AsyncNotifierProvider<AsyncLoginNotifier, String>(() {
  return AsyncLoginNotifier();
});
