import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:usercrudapi/Models/user.dart';

class UserServices {

  // Android Emulator
  // static const String baseurl =
  //     'http://10.0.2.2:2000/users';
  static const String baseurl = 'http://10.138.248.172:2000/users';

  // Real Device Example
  // static const String baseurl =
  // 'http://192.168.1.5:2000/users';

  static Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse(baseurl),
    );

    if (response.statusCode == 200) {
      List<dynamic> data =
      jsonDecode(response.body);

      return data
          .map(
            (userJson) =>
            User.fromJson(userJson),
      )
          .toList();
    }

    throw Exception('Failed to load users');
  }

  static Future<void> addUser(
      String name,
      int age,
      ) async {

    final response = await http.post(
      Uri.parse(baseurl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "age": age,
        "role": "User",
      }),
    );

    if (response.statusCode != 201) {
      throw Exception(
        "Failed to add user",
      );
    }
  }

  static Future<void> updateUser(
      String id,
      String name,
      int age,
      String role,
      ) async {

    final response = await http.put(
      Uri.parse('$baseurl/$id'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "name": name,
        "age": age,
        "role": role,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to update user",
      );
    }
  }

  static Future<void> deleteUser(
      String id,
      ) async {

    final response = await http.delete(
      Uri.parse('$baseurl/$id'),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Failed to delete user",
      );
    }
  }
}