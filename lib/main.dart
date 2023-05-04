import 'package:csc13118_mobile/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:csc13118_mobile/features/authentication/login.dart';
import 'package:csc13118_mobile/features/courses/InformationCourse.dart';
import 'package:csc13118_mobile/routing/routes.dart';
import 'package:csc13118_mobile/page/navigationPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

void main() => runApp(const ProviderScope(child: LetTutor()));


class LetTutor extends StatelessWidget {
  const LetTutor({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'LetTutor',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const LoginPage(),
        routes: {
          Routes.login: (context) => const LoginPage(),
          Routes.main: (context) => const NavigationPage(choice: 0),
          Routes.tutors: (context) =>  const NavigationPage(choice: 2,),
          Routes.history: (context) =>  const NavigationPage(choice: 3,),
          Routes.courseDetail: (context) => const NavigationPage(choice: 4,),
        });
  }
}