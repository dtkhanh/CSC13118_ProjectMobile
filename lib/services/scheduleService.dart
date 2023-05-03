
import 'dart:convert';

import 'package:csc13118_mobile/model/tutor/infoTutor.dart';
import 'package:http/http.dart';

import '../model/schedule/bookingInfo.dart';
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
  static Future<void> booking({
    required List<String> scheduleDetailIds,
    required String note,
    required String token,
  }) async {
    final response = await post(
      Uri.parse('$url/booking'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'scheduleDetailIds': scheduleDetailIds,
        'note': note,
      }),
    );
    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
  }

  static Future<List<BookingInfo>> getListClassBooking({
    required String token,
    required int page,
    required int perPage,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final response = await get(
      Uri.parse('$url/booking/list/student?page=$page&perPage=$perPage&dateTimeGte=$now&orderBy=meeting&sortBy=asc'),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    final List<dynamic> listBookingClass = jsonDecode['data']['rows'];
    return listBookingClass.map((schedule) => BookingInfo.fromJson(schedule)).toList();
  }

}