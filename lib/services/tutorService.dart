
import 'dart:convert';
import 'package:csc13118_mobile/model/tutor/infoTutor.dart';
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
  static Future<List<Tutor>> getListTutorWithSearch({
    String search = '',
    required int page,
    required int perPage,
    List<String> specialties = const [],
    nationality =  json,
    required String token,
  }) async {
    final response = await post(
      Uri.parse('$url/tutor/search'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'page': page,
        'perPage': perPage,
        'search': search,
        'filters': {
          'specialties': specialties,
          // 'nationality': nationality,
        }
      })
    );
    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200 ) {
      throw Exception(jsonDecode!['message']);
    }else{
      List<dynamic> tutors = jsonDecode['rows'];
      return tutors.map((tutor) => Tutor.fromJson(tutor)).toList();
    }
  }
  static Future<dynamic> getToTalElement({
    String search = '',
    required int page,
    required int perPage,
    List<String> specialties = const [],
    nationality =  json,
    required String token,
  }) async {
    final response = await post(
        Uri.parse('$url/tutor/search'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'page': page,
          'perPage': perPage,
          'search': search,
          'filters': {
            'specialties': specialties,
            // 'nationality': nationality,
          }
        })
    );
    final jsonDecode = json.decode(response.body);

    if (response.statusCode != 200 ) {
      throw Exception(jsonDecode!['message']);
    }else{
      return jsonDecode['count'];
    }
  }
  static Future<InfoTutor> getIdTutor({
    required String token,
    required String userId,
  }) async {
    final response = await get(
      Uri.parse('$url/tutor/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    return InfoTutor.fromJson(jsonDecode);
  }
  static Future<void> addFavoriteTutor({
    required String token,
    required String tutorId,
  }) async {
    final response = await post(
      Uri.parse('$url/user/manageFavoriteTutor'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
          'tutorId': tutorId,
        }),
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }

  static Future<void> reportTutor({
    required String token,
    required String tutorId,
    required String content,
  }) async {
    final response = await post(
      Uri.parse('$url/report'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(
        {
          'tutorId': tutorId,
          'content': content,
        },
      ),
    );
    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }


}