import 'package:json_annotation/json_annotation.dart';

part 'story.g.dart';

@JsonSerializable()
class Story {
  String? id;
  String? name;
  String? description;
  String? photoUrl;
  String? createdAt;
  double? lat;
  double? lon;

  Story(
      {this.id,
      this.name,
      this.description,
      this.photoUrl,
      this.createdAt,
      this.lat,
      this.lon});

  factory Story.fromJson(json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);

// Story.fromJson(Map<String, dynamic> json) {
//   id = json['id'];
//   name = json['name'];
//   description = json['description'];
//   photoUrl = json['photoUrl'];
//   createdAt = json['createdAt'];
//   lat = json['lat'];
//   lon = json['lon'];
// }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = id;
//   data['name'] = name;
//   data['description'] = description;
//   data['photoUrl'] = photoUrl;
//   data['createdAt'] = createdAt;
//   data['lat'] = lat;
//   data['lon'] = lon;
//   return data;
// }
}
