
import 'dart:convert';

import 'package:http/http.dart';

import '../model/tutor/tutor.dart';

class TuTorService {

  static const url =  'https://sandbox.api.lettutor.com';

  static Future<List<Tutor>> getTutors({
    required int page,
    required int perPage,
    required String token,
  }) async {
    final response = await get(
      Uri.parse('$url/tutor/more?perPage=$perPage&page=$page'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200 ) {
      throw Exception(jsonDecode!['message']);
    }else{
      List<dynamic> tutors = jsonDecode['tutors']['rows'];
      return tutors.map((tutor) => Tutor.fromJson(tutor)).toList();
    }
  }


}