import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/token.dart';
import '../model/user.dart';
class AuthenticationService {

  static const url =  'https://sandbox.api.lettutor.com';

  Future<Map<String, dynamic>> loginAccount({required String email, required String password}) async {
    final response = await post(
      Uri.parse('$url/auth/login'),
      // headers:{
      //   'Content-Type': 'application/json; charset=UTF-8',
      // },
      body: {
        'email': email,
        'password': password
      }
    );

    if (response.statusCode == 200) {
      final jsonDecode = json.decode(response.body);
      return  jsonDecode;
    } else {
      // return json.decode(response.body);
      throw Exception('Failed to Login account.');
    }
  }

}