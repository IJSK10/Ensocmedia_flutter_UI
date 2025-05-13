class tokendata {
  tokendata({
    required this.token,
  });
  String? token;

  factory tokendata.fromjson(Map<String, dynamic> json) {
    return tokendata(token: json['token']);
  }

  Map<String, dynamic> toJson() => {
        'token': token,
      };
}
