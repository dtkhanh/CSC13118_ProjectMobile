
import 'dart:convert';

import 'package:csc13118_mobile/model/tutor/infoTutor.dart';
import 'package:http/http.dart';

import '../model/schedule/bookingInfo.dart';
import '../model/schedule/schedule.dart';
import '../model/tutor/tutor.dart';
class UserService {
  static const url = 'https://sandbox.api.lettutor.com';
  static Future<Map<String, dynamic>> getTotalCall({
    required String token,
  }) async {
    final response = await get(Uri.parse('$url/call/total'),
      headers: {
        'Authorization': 'Bearer $token',
      },);


    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(['message']));
    }
    return  jsonDecode;
  }



}