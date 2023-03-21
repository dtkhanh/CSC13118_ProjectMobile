import 'package:csc13118_mobile/src/InformationTeacher.dart';
import 'package:flutter/material.dart';
import 'package:csc13118_mobile/src/app.dart';
import 'package:csc13118_mobile/src/login.dart';
import 'package:csc13118_mobile/src/homeView.dart';
import 'package:csc13118_mobile/src/scheduleView.dart';
import 'package:csc13118_mobile/src/historyView.dart';
import 'package:csc13118_mobile/src/discoverCoursesView.dart';
import 'package:csc13118_mobile/src/InformationCourse.dart';
import 'package:csc13118_mobile/constants/routes.dart';
import 'package:csc13118_mobile/page/navigationPage.dart';
import 'package:csc13118_mobile/src/topicDetail.dart';
import 'package:csc13118_mobile/src/teamView.dart';

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