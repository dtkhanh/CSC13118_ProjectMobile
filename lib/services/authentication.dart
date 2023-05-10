import 'dart:convert';
import 'package:http/http.dart';

class AuthenticationService {

  static const url =  'https://sandbox.api.lettutor.com';

  Future<Map<String, dynamic>> loginAccount({required String email, required String password}) async {
    final response = await post(
      Uri.parse('$url/auth/login'),
      body: {
        'email': email,
        'password': password
      }
    );
    final jsonDecode = json.decode(response.body);
    if (response.statusCode == 200) {
      return  jsonDecode;
    } else {
      throw Exception(jsonDecode!['message']);
    }
  }

  static Future<Map<String, dynamic>> registerAccount({
    required String email,
    required String password,
  }) async {
    final response = await post(
      Uri.parse("$url/auth/register"),
      body: {
        'email': email,
        'password': password,
        "source": 'null',
      },
    );
    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 201 ) {
      // throw Exception('Failed to Register account.');
      throw Exception(jsonDecode!['message']);
    }else{
      return jsonDecode;
    }
  }

  static Future<Map<String, dynamic>> forgotPassword( {required String email}) async {
    final response = await post(
      Uri.parse("$url/user/forgotPassword"),
      body: {
        'email': email,
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode!['message']);
    }else{
      return jsonDecode;
    }
  }

}