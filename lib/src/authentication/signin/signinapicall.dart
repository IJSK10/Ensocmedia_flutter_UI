import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/src/datamodels/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AsyncUserNotifier extends AsyncNotifier<int> {
  @override
  Future<int> build() async {
    return 200;
  }

  Future<int> createUser(User user) async {
    print("before calling");
    final response = await http
        .post(
          //Uri.https("https://a36b-103-146-175-141.ngrok-free.app/signin"),
          Uri.parse("https://47ec-103-168-201-78.ngrok-free.app/signin"),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode(user.toJson()),
        )
        .timeout(const Duration(seconds: 5));
    final statuscode = response.statusCode;
    return statuscode;
  }

  Future<void> loading() async {
    state = const AsyncValue.loading();
  }

  Future<void> notfinished() async {
    state = const AsyncValue.data(400);
  }
}

final asyncUserProvider = AsyncNotifierProvider<AsyncUserNotifier, int>(() {
  return AsyncUserNotifier();
});

Future<int> signincall(User user) async {
  final response = await http
      .post(Uri.parse("https://httpbin.org/post"),
          headers: {'Content-type': 'application/json'},
          body: jsonEncode(user.toJson()))
      .timeout(const Duration(seconds: 10));
  print(response.body);
  final statuscode = response.statusCode;
  return statuscode;
}
