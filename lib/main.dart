import 'package:csc13118_mobile/features/view_information/teacher_info/InformationTeacher.dart';
import 'package:flutter/material.dart';
import 'package:csc13118_mobile/features/login/login.dart';
import 'package:csc13118_mobile/features/homepage/homeView.dart';
import 'package:csc13118_mobile/features/schedule/scheduleView.dart';
import 'package:csc13118_mobile/features/history/historyView.dart';
import 'package:csc13118_mobile/features/courses/discoverCoursesView.dart';
import 'package:csc13118_mobile/features/courses/InformationCourse.dart';
import 'package:csc13118_mobile/routing/routes.dart';
import 'package:csc13118_mobile/page/navigationPage.dart';
import 'package:csc13118_mobile/features/courses/topicDetail.dart';
import 'package:csc13118_mobile/features/call_video/teamView.dart';

void main() => runApp(const LetTutor());


class LetTutor extends StatelessWidget {
  const LetTutor({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      MaterialApp(
        title: 'LetTutor',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const LoginPage(),
        routes: {
          Routes.login: (context) => const LoginPage(),
          Routes.main: (context) => const NavigationPage(),
          Routes.courseDetail: (context) => const InformationCourseView(),
        });
  }
}