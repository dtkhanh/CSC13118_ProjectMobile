import "package:flutter/material.dart";
import 'package:csc13118_mobile/src/login.dart';
import 'package:csc13118_mobile/src/homeView.dart';
import 'package:csc13118_mobile/src/scheduleView.dart';
import 'package:csc13118_mobile/src/historyView.dart';
import 'package:csc13118_mobile/src/DiscoverCoursesView.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DiscoverCourses());
  }
}