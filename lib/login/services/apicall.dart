import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:project/src/datamodels/user.dart';
import "package:http/http.dart" as http;

part 'apicall.g.dart';

@riverpod
class UserList extends _$UserList {
  @override
  Future<int> build() async => 5;
  Future<void> addUser(User user) async {
    print("before calling");
    final response = await http.post(
      Uri.https("httpbin.org", 'post'),
      headers: {'Content-type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );
    print("respsonse");
    print(response.statusCode);
  }
}
