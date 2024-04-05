import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  bool? error;
  String? message;

  BaseResponse({this.error, this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);

// BaseResponse.fromJson(Map<String, dynamic> json) {
//   error = json['error'];
//   message = json['message'];
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['error'] = error;
//   data['message'] = message;
//   return data;
// }
}
