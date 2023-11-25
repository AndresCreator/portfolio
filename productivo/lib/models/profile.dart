import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  String name;
  String lastName;
  int age;
  String gender;

  Profile({
    required this.name,
    required this.lastName,
    required this.age,
    required this.gender,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      lastName: json['lastName'],
      age: json['age'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lastName': lastName,
      'age': age,
      'gender': gender,
    };
  }

  // Save the profile to SharedPreferences
  Future<void> saveProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String profileJson = jsonEncode(toJson());
    await prefs.setString('profile', profileJson);
  }

  // Load the profile from SharedPreferences
  static Future<Profile?> loadProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? profileJson = prefs.getString('profile');
    if (profileJson != null) {
      return Profile.fromJson(jsonDecode(profileJson));
    } else {
      return null;
    }
  }

  // Delete the profile from SharedPreferences
  static Future<void> deleteProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile');
  }
}
