import 'package:flutter_story_app/app/data/response/story.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_story_response.g.dart';

@JsonSerializable()
class ListStoryResponse {
  bool? error;
  String? message;

  @JsonKey(name: "listStory")
  List<Story>? listStory;

  ListStoryResponse({this.error, this.message, this.listStory});

  factory ListStoryResponse.fromJson(json) => _$ListStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListStoryResponseToJson(this);

// ListStoryResponse.fromJson(Map<String, dynamic> json) {
//   error = json['error'];
//   message = json['message'];
//   if (json['listStory'] != null) {
//     listStory = <Story>[];
//     json['listStory'].forEach((v) {
//       listStory!.add(Story.fromJson(v));
//     });
//   }
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['error'] = error;
//   data['message'] = message;
//   if (listStory != null) {
//     data['listStory'] = listStory!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}
