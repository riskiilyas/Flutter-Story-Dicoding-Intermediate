import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_story_app/app/data/provider/pref.dart';
import 'package:http/http.dart' as http;

import '../response/base_response.dart';
import '../response/detail_story_response.dart';
import '../response/list_story_response.dart';
import '../response/login_response.dart';

class Network {
  final String _baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<BaseResponse> register(
      String name, String email, String password) async {
    final url = Uri.parse('$_baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return BaseResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register user.');
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login.');
    }
  }

  Future<BaseResponse> uploadStory(
    List<int> bytes,
    String fileName,
    String description,
    double? lat,
    double? lon,
  ) async {
    String url = "$_baseUrl/stories";

    final uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri);

    final multiPartFile = http.MultipartFile.fromBytes(
      "photo",
      bytes,
      filename: fileName,
    );
    final token = await Pref.getToken();

    final Map<String, String> fields = {
      "description": description,
      if (lat != null) "lat": lat.toString(),
      if (lon != null) "lon": lon.toString(),
    };
    final Map<String, String> headers = {
      "Content-type": "multipart/form-data",
      'Authorization': 'Bearer $token'
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      final BaseResponse uploadResponse = BaseResponse.fromJson(
        jsonDecode(responseData),
      );
      return uploadResponse;
    } else {
      throw Exception("Upload file error");
    }
  }

  Future<ListStoryResponse> getAllStories(
      {int? page, int? size, int? location}) async {
    final url = Uri.parse('$_baseUrl/stories').replace(queryParameters: {
      'page': page?.toString(),
      'size': size?.toString(),
      // 'location': location?.toString(),
    });

    final token = await Pref.getToken();
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (kDebugMode) {
      print("token: $token\nres: ${response.body}");
    }

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return ListStoryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get stories.');
    }
  }

  Future<DetailStoryResponse> getStoryDetail(String storyId) async {
    final url = Uri.parse('$_baseUrl/stories/$storyId');
    final token = await Pref.getToken();

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return DetailStoryResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get story detail.');
    }
  }
}
