import 'package:json_annotation/json_annotation.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  String? userId;
  String? name;
  String? token;

  LoginResult({this.userId, this.name, this.token});

  factory LoginResult.fromJson(json) => _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

// LoginResult.fromJson(Map<String, dynamic> json) {
//   userId = json['userId'];
//   name = json['name'];
//   token = json['token'];
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['userId'] = userId;
//   data['name'] = name;
//   data['token'] = token;
//   return data;
// }
}
