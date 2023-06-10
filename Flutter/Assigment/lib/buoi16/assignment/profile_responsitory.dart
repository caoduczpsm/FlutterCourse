import 'dart:convert';

import 'package:buoi_4_bai_1/buoi16/assignment/ProfileData.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ProfileRepository{
  static const String urlRead = "https://645efc1d9d35038e2d1b1486.mockapi.io/trainee-app/trainees";
  static const String urlCreate = "https://645efc1d9d35038e2d1b1486.mockapi.io/trainee-app/trainees";

  static const int statusCode200 = 200;
  static const int statusCode201 = 201;

  Future<List<ProfileData>> getAllProfiles() async {
    final uri = Uri.parse(urlRead);
    final response = await http.get(uri);
    if(response.statusCode == statusCode200){
      return parseData(response.body);
    }

    throw Exception("Failed to load Profile data ${response.statusCode}");
  }

  List<ProfileData> parseData(String body){
    final parsed = jsonDecode(body).cast<Map<String, dynamic>>();
    return parsed.map<ProfileData>((json) => ProfileData.fromJson(json)).toList();
  }

  Future<ProfileData> createProfile(ProfileData profileData) async {
    final uri = Uri.parse(urlCreate);
    final body = {
      'name': profileData.name,
      'email': profileData.email,
      'age': profileData.age
    };

    final response = await http.post(uri, body: body);
    if(response.statusCode == statusCode201) {
      return ProfileData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create profile ${response.statusCode}');
    }
  }

  Future<ProfileData> updateProfile(ProfileData profileData) async {
    final id = profileData.id!;
    final url = "$urlRead/$id";
    final uri = Uri.parse(url);
    final body = {
      "name": profileData.name,
      "email": profileData.email,
      "age": profileData.age,
    };
    final response = await http.put(uri, body: body);

    if(response.statusCode == statusCode200) {
      return ProfileData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update profile ${response.statusCode}');
    }
  }

  Future<ProfileData> deleteById(String id) async {
    final url = "$urlRead/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if(response.statusCode == statusCode200) {
      return ProfileData.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to delete profile ${response.statusCode}');
    }
  }

}