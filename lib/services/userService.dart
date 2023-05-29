
import 'dart:convert';
import 'package:http/http.dart';
import '../model/schedule/bookingInfo.dart';
import '../model/user.dart';
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

  static Future<User> getUserInformation({
    required String token,
  }) async {
    final response = await get(Uri.parse('$url/user/info'),
      headers: {
        'Authorization': 'Bearer $token',
      },);


    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(['message']));
    }
    return User.fromJson(jsonDecode["user"]);
  }

  static Future<User> UpdateInformation({
    required String token,
    required String name,
    required String country,
    required String phone,
    required String birthday,
    required String level,
    required String studySchedule,
  }) async {
    final response = await put(Uri.parse('$url/user/info'),
      headers: {
        'Content-Type': 'application/json;encoding=utf-8',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'name': name,
        'country': country,
        'phone': phone,
        'birthday': birthday,
        'level': level,
        'studySchedule': studySchedule,
      }),
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode(['message']));
    }
    return User.fromJson(jsonDecode["user"]);
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
      if (a.scheduleDetailInfo == null || b.scheduleDetailInfo == null) return 0;
      if (a.scheduleDetailInfo!.startPeriodTimestamp == null ||
          b.scheduleDetailInfo!.startPeriodTimestamp == null) return 0;
      final int timestamp1 = a.scheduleDetailInfo!.startPeriodTimestamp!;
      final int timestamp2 = b.scheduleDetailInfo!.startPeriodTimestamp!;
      return timestamp1.compareTo(timestamp2);
    });

    lessons = lessons.where((element) {
      if (element.scheduleDetailInfo == null) return false;
      if (element.scheduleDetailInfo!.startPeriodTimestamp == null) return false;
      final int startTimestamp = element.scheduleDetailInfo!.startPeriodTimestamp!;
      return startTimestamp > now;
    }).toList();

    return lessons.first;
    // if (lessons.isNotEmpty) {
    //   return lessons.first;
    // } else {
    //   throw Exception('Error: Cannot get lesson Upcoming');
    // }
  }


}