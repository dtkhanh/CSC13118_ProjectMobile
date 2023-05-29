import 'package:csc13118_mobile/providers/activateTheme.dart';
import 'package:flutter/material.dart';
import 'package:csc13118_mobile/features/authentication/login.dart';
import 'package:csc13118_mobile/routing/routes.dart';
import 'package:csc13118_mobile/page/navigationPage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'constants/themes.dart';

void main() => runApp(const ProviderScope(child: LetTutor()));

class LetTutor extends ConsumerWidget {
  const LetTutor({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeThemeProvider = ref.watch(activeTheme);

    return MaterialApp(
        title: 'LetTutor',
        // debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme:darkTheme,
        themeMode: activeThemeProvider == Themes.dark ? ThemeMode.dark : ThemeMode.light,
        // theme: ThemeData(
        //   useMaterial3: true,
        //   primaryColor: Colors.blue,
        //   scaffoldBackgroundColor: Colors.white,
        // ),
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

