
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
  static Future<BookingInfo> getUpcomingLesson({
    required String token,
  }) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    final response = await get(
      Uri.parse('$url/booking/next?dateTime=$now'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }

    final List<dynamic> data = jsonDecode['data'];
    List<BookingInfo> lessons = data.map((schedule) => BookingInfo.fromJson(schedule)).toList();

    lessons.sort((a, b) {
      if (a.scheduleDetailInfo == null || b.scheduleDetailInfo == null || a.scheduleDetailInfo!.startPeriodTimestamp == null || b.scheduleDetailInfo!.startPeriodTimestamp == null) return 0;
      return a.scheduleDetailInfo!.startPeriodTimestamp!.compareTo(b.scheduleDetailInfo!.startPeriodTimestamp!);
    });

    lessons = lessons.where((element) {
      if (element.scheduleDetailInfo == null || element.scheduleDetailInfo!.startPeriodTimestamp == null) return false;
      return element.scheduleDetailInfo!.startPeriodTimestamp! > now;
    }).toList();

    if (lessons.isNotEmpty) {
      return lessons.first;
    } else {
      throw Exception('Error: Cannot get lesson Upcoming');
    }
  }


}