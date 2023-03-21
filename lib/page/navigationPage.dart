import 'package:flutter/material.dart';
import 'package:csc13118_mobile/features/login/login.dart';
import 'package:csc13118_mobile/features/homepage/homeView.dart';
import 'package:csc13118_mobile/features/schedule/scheduleView.dart';
import 'package:csc13118_mobile/features/history/historyView.dart';
import 'package:csc13118_mobile/features/courses/discoverCoursesView.dart';


class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  List<Widget> pages = [
    const HomeView(),
    const ScheduleView(),
    const historyView(),
    const DiscoverCourses(),
    const LoginPage(),
    const LoginPage(),
  ];

  List<String> pagesTitle = [ 'TUTORS', 'SCHEDULE', 'COURSES', 'MY COURSE'];
  int chosenPageIndex = 0;
  int check =0;


  bool _isExpnaded = false;
  bool checkclick = false;

  void _onItemTapped(int index) {
    setState(() {
      chosenPageIndex = index;
      _isExpnaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    MediaQuery.of(context).size.width > 768 ? _isExpnaded=false : true;
    return Scaffold(
        appBar:AppBar(
          title: Text(
            'LetTutor',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              //letterSpacing: 1.0,
              color: Colors.blue[600],
            ),
          ),
          actions: [
            MediaQuery.of(context).size.width > 768
                ? Row(
              children: [
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    _onItemTapped(0);
                  },
                  child: const Text('TUTORS'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    _onItemTapped(1);
                  },
                  child: const Text('SCHEDULE'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {_onItemTapped(2);  },
                  child: const Text('HISTORY'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    _onItemTapped(3);
                  },
                  child: const Text('COURSES'),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () { },
                  child: const Text('MY COURSE'),
                ),
              ],
            )
                : IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                setState(() {
                  _isExpnaded = !_isExpnaded;
                });
              },
            ),
          ],
        ),
      body: !_isExpnaded ? pages[chosenPageIndex] : Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              const Icon(Icons.home_filled, color: Colors.yellow),
              const SizedBox(width: 5),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  _onItemTapped(0);
                },
                child: const Text('TUTORS'),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.schedule_outlined, color: Colors.yellow),
              const SizedBox(width: 5),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  _onItemTapped(1);
                },
                child: const Text('SCHEDULE'),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.phone_paused, color: Colors.yellow),
              const SizedBox(width: 5),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {   _onItemTapped(2);},
                child: const Text('HISTORY'),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.school, color: Colors.yellow),
              const SizedBox(width: 5),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  _onItemTapped(3);
                },
                child: const Text('COURSES'),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.menu_book, color: Colors.yellow),
              const SizedBox(width: 5),
              TextButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () { },
                child: const Text('MY COURSE'),
              ),
            ],
          ),
        ],
      ) ,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 14,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            chosenPageIndex = value;
          });
        },
        elevation: 20,
        selectedItemColor: Colors.blue,
        currentIndex: chosenPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home'
          ),
          BottomNavigationBarItem(icon: Icon(Icons.schedule_outlined), label: 'Schedule'),
          BottomNavigationBarItem(icon: Icon(Icons.phone_paused), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
        ],
      ),
    );
  }
}
