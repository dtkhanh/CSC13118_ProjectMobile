
import 'dart:convert';

import 'package:csc13118_mobile/model/tutor/infoTutor.dart';
import 'package:http/http.dart';

import '../model/schedule/schedule.dart';
import '../model/tutor/tutor.dart';
class ScheduleService {
  static const url = 'https://sandbox.api.lettutor.com';
  static Future<List<Schedule>> getScheduleByTutorId({
    required String token,
    required String userId,
  }) async {
    final response = await post(Uri.parse('$url/schedule'),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body:{
      'tutorId': userId,
    },);


    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(['message']));
    }
    List<dynamic> listSchedule = jsonDecode['data'] ;

    return listSchedule.map((schedule) => Schedule.fromJson(schedule)).toList();
    }
}