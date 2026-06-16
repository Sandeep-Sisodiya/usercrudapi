import 'dart:convert';

import 'package:usercrudapi/Models/user.dart';
import 'package:http/http.dart' as http;

class UserServices{
  static const String baseurl = 'http://10.0.2.2:2000/users';

  static Future<List<User>> fetchUsers() async{
    final response = await http.get(Uri.parse(baseurl));

    if(response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((userJson) => User.fromJson(userJson)).toList();
    }else{
      throw Exception('Failed to load Data');
    }
  }
}