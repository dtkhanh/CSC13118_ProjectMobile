
import 'dart:convert';
import 'package:http/http.dart';

import '../model/course/course.dart';
class CourseService {
  static const url = 'https://sandbox.api.lettutor.com';

  static Future<List<Course>> getListCourse({
    required String token,
  }) async {
    final response = await get(
      Uri.parse('$url/course?page=1&size=10'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    final List<dynamic> courses = jsonDecode['data']['rows'];
    return courses.map((course) => Course.fromJson(course)).toList();
  }
  static Future<List<Course>> getListCourseE_book({
    required String token,
  }) async {
    final response = await get(
      Uri.parse('$url/e-book?page=1&size=10'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    final List<dynamic> courses = jsonDecode['data']['rows'];
    return courses.map((course) => Course.fromJson(course)).toList();
  }
  static Future<List<Course>> getListCourse_Interactive_Ebook({
    required String token,
  }) async {
    final response = await get(
      Uri.parse('$url/material/interactive-e-book?page=1&size=10'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    final jsonDecode = json.decode(response.body);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    final List<dynamic> courses = jsonDecode['data']['rows'];
    return courses.map((course) => Course.fromJson(course)).toList();
  }
  static Future<Course> getCourseDetail({
    required String token,
    required String id
    }) async {
    final response = await get(
      Uri.parse('$url/course/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    final jsonDecode = json.decode(response.body);
    final Course course = Course.fromJson(jsonDecode['data']);
    if (response.statusCode != 200) {
      throw Exception(jsonDecode['message']);
    }
    return course;
  }
}