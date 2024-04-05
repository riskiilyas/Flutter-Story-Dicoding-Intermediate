import 'package:json_annotation/json_annotation.dart';

import 'detail_story.dart';

part 'detail_story_response.g.dart';

@JsonSerializable()
class DetailStoryResponse {
  bool? error;
  String? message;

  @JsonKey(name: "story")
  DetailStory? story;

  DetailStoryResponse({this.error, this.message, this.story});

  factory DetailStoryResponse.fromJson(json) =>
      _$DetailStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailStoryResponseToJson(this);

// DetailStoryResponse.fromJson(Map<String, dynamic> json) {
//   error = json['error'];
//   message = json['message'];
//   story = json['story'] != null ? Story.fromJson(json['story']) : null;
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['error'] = error;
//   data['message'] = message;
//   if (story != null) {
//     data['story'] = story!.toJson();
//   }
//   return data;
// }
}
