import 'package:json_annotation/json_annotation.dart';

import 'login_result.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  bool? error;
  String? message;

  @JsonKey(name: "loginResult")
  LoginResult? loginResult;

  LoginResponse({this.error, this.message, this.loginResult});

  factory LoginResponse.fromJson(json) => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

// LoginResponse.fromJson(Map<String, dynamic> json) {
//   error = json['error'];
//   message = json['message'];
//   loginResult = json['loginResult'] != null
//       ? LoginResult.fromJson(json['loginResult'])
//       : null;
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['error'] = error;
//   data['message'] = message;
//   if (loginResult != null) {
//     data['loginResult'] = loginResult!.toJson();
//   }
//   return data;
// }
}
