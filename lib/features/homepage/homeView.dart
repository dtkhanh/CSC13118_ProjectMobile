import 'package:csc13118_mobile/features/tutors/widget/cardTutor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/appSizes.dart';
import '../../model/schedule/bookingInfo.dart';
import '../../model/tutor/tutor.dart';
import '../../routing/routes.dart';
import '../../services/tutorService.dart';
import '../../services/userService.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewStage();
}

class _HomeViewStage extends State<HomeView> {
  int chosenFilter = 0;
  bool checkData = false;
  List<Tutor> listTutor = [];
  List<dynamic>? responseTutor;
  Map<String, dynamic>? _total;
  int _totalCall = 0;
  BookingInfo? _upComing;


  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    getListTutor(check!);
  }
  void getTotalCall() async {
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    _total = await UserService.getTotalCall(token: check!);
    final upComing = await UserService.getUpcomingLesson(token: check);
    if (mounted) {
      setState(() {
        checkData = true;
        _totalCall = int.parse(_total!["total"].toString());
        _upComing = upComing;
      });
    }
  }


  void getListTutor(String tokenUser) async {
    try{
      listTutor = await TuTorService.getTutors(page: 1,perPage: 9,token: tokenUser);
      if (mounted) {
        setState(() {
          checkData = true;
        });
      }
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login: ${e.toString()}')),
      );
    }
  }
  String _convertTotalLessonTime() {
    if (_totalCall == 0) {
      return 'You have not attended any class';
    }
    String result = 'Total Lesson Time:';
    final int hour = _totalCall ~/ 60;
    final int minute = _totalCall - hour * 60;
    result += hour > 0 ? ' $hour ${hour > 1 ? 'hours' : 'hour'}' : '';
    result += minute > 0 ? ' $minute ${minute > 1 ? 'minutes' : 'minute'}' : '';
    return result;
  }

  @override
  Widget build(BuildContext context) {
    _initPrefs();
    getTotalCall();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue[700],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Upcoming Lesson',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Sizes.p20, color: Colors.white),
                    ),
                  ),
                  _upComing == null?
                  const Text(
                    '',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: Sizes.p20, color: Colors.white),
                  )
                      :
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(_upComing?.scheduleDetailInfo!.startPeriodTimestamp ?? 0))} ',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: Sizes.p16, color: Colors.white),
                      ),
                      Text(
                          '${DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(_upComing?.scheduleDetailInfo!.startPeriodTimestamp ?? 0))} - ',
                        style: const TextStyle(fontStyle: FontStyle.normal, fontSize: Sizes.p12, color: Colors.yellow),
                      ),
                      Text(
                        DateFormat.Hm().format(DateTime.fromMillisecondsSinceEpoch(_upComing?.scheduleDetailInfo!.endPeriodTimestamp ?? 0)),
                        style: const TextStyle(fontStyle: FontStyle.normal, fontSize: Sizes.p12, color: Colors.yellow),
                      ),
                      gapW4,
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15), // set the radius here
                          ),
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: Sizes.p16,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),),
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          String? userId =  prefs.getString('userId');
                          JitsiMeetingOptions options = JitsiMeetingOptions(roomNameOrUrl:'cb9e7deb-3382-48db-b07c-90acf52f541c-4d54d3d7-d2a9-42e5-97a2-5ed38af5789a', serverUrl: "https://meet.lettutor.com/", token: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjb250ZXh0Ijp7InVzZXIiOnsiZW1haWwiOiJwaGhhaUB5bWFpbC5jb20iLCJuYW1lIjoicGhoYWkifX0sInJvb20iOiJjYjllN2RlYi0zMzgyLTQ4ZGItYjA3Yy05MGFjZjUyZjU0MWMtNGQ1NGQzZDctZDJhOS00MmU1LTk3YTItNWVkMzhhZjU3ODlhIiwicm9vbU5hbWUiOiJjYjllN2RlYi0zMzgyLTQ4ZGItYjA3Yy05MGFjZjUyZjU0MWMtNGQ1NGQzZDctZDJhOS00MmU1LTk3YTItNWVkMzhhZjU3ODlhIiwidXNlckNhbGwiOnsiaWQiOiJjYjllN2RlYi0zMzgyLTQ4ZGItYjA3Yy05MGFjZjUyZjU0MWMiLCJlbWFpbCI6InBoaGFpQHltYWlsLmNvbSIsIm5hbWUiOiJwaGhhaSIsImF2YXRhciI6Imh0dHBzOi8vc2FuZGJveC5hcGkubGV0dHV0b3IuY29tL2F2YXRhci9jYjllN2RlYi0zMzgyLTQ4ZGItYjA3Yy05MGFjZjUyZjU0MWNhdmF0YXIxNjgzMTA0NDI4MzU1LmpwZyIsImNvdW50cnkiOiJWTiIsInBob25lIjoiODQyNDk5OTk2NTA4IiwibGFuZ3VhZ2UiOm51bGwsImJpcnRoZGF5IjoiMTk5OS0wNi0wMyIsImlzQWN0aXZhdGVkIjp0cnVlLCJyZXF1aXJlTm90ZSI6IktvIHRoaWNoIGhvYyIsImxldmVsIjoiSElHSEVSX0JFR0lOTkVSIiwiaXNQaG9uZUFjdGl2YXRlZCI6dHJ1ZSwidGltZXpvbmUiOjcsInN0dWR5U2NoZWR1bGUiOiJLbyB0aGljaCBob2MiLCJjYW5TZW5kTWVzc2FnZSI6ZmFsc2V9LCJ1c2VyQmVDYWxsZWQiOnsiaWQiOiI0ZDU0ZDNkNy1kMmE5LTQyZTUtOTdhMi01ZWQzOGFmNTc4OWEiLCJlbWFpbCI6InRlYWNoZXJAbGV0dHV0b3IuY29tIiwibmFtZSI6IktlZWdhbiIsImF2YXRhciI6Imh0dHBzOi8vYXBpLmFwcC5sZXR0dXRvci5jb20vYXZhdGFyLzRkNTRkM2Q3LWQyYTktNDJlNS05N2EyLTVlZDM4YWY1Nzg5YWF2YXRhcjE2Mjc5MTMwMTU4NTAuMDAiLCJjb3VudHJ5IjoiVk4iLCJwaG9uZSI6Ijg0MzU2MDMwODc2IiwibGFuZ3VhZ2UiOiJVa3JhaW5pYW4iLCJiaXJ0aGRheSI6IjE5OTktMDYtMDEiLCJpc0FjdGl2YXRlZCI6dHJ1ZSwidHV0b3JJbmZvIjp7ImlkIjoiNmNhNWMwOTItNzZlYS00ZTcyLTljNmUtMDVlMjIzOWFhMzNiIiwidXNlcklkIjoiNGQ1NGQzZDctZDJhOS00MmU1LTk3YTItNWVkMzhhZjU3ODlhIiwidmlkZW8iOiJodHRwczovL2FwaS5hcHAubGV0dHV0b3IuY29tL3ZpZGVvLzRkNTRkM2Q3LWQyYTktNDJlNS05N2EyLTVlZDM4YWY1Nzg5YXZpZGVvMTYyNzkxMzAxNTg3MS5tcDQiLCJiaW8iOiJJIGFtIHBhc3Npb25hdGUgYWJvdXQgcnVubmluZyBhbmQgZml0bmVzcywgSSBvZnRlbiBjb21wZXRlIGluIHRyYWlsL21vdW50YWluIHJ1bm5pbmcgZXZlbnRzIGFuZCBJIGxvdmUgcHVzaGluZyBteXNlbGYuIEkgYW0gdHJhaW5pbmcgdG8gb25lIGRheSB0YWtlIHBhcnQgaW4gdWx0cmEtZW5kdXJhbmNlIGV2ZW50cy4gSSBhbHNvIGVuam95IHdhdGNoaW5nIHJ1Z2J5IG9uIHRoZSB3ZWVrZW5kcywgcmVhZGluZyBhbmQgd2F0Y2hpbmcgcG9kY2FzdHMgb24gWW91dHViZS4gTXkgbW9zdCBtZW1vcmFibGUgbGlmZSBleHBlcmllbmNlIHdvdWxkIGJlIGxpdmluZyBpbiBhbmQgdHJhdmVsaW5nIGFyb3VuZCBTb3V0aGVhc3QgQXNpYS4iLCJlZHVjYXRpb24iOiJCQSIsImV4cGVyaWVuY2UiOiJJIGhhdmUgbW9yZSB0aGFuIDEwIHllYXJzIG9mIHRlYWNoaW5nIGVuZ2xpc2ggZXhwZXJpZW5jZSIsInByb2Zlc3Npb24iOiJFbmdsaXNoIHRlYWNoZXIiLCJhY2NlbnQiOm51bGwsInRhcmdldFN0dWRlbnQiOiJBZHZhbmNlZCIsImludGVyZXN0cyI6IiBJIGxvdmVkIHRoZSB3ZWF0aGVyLCB0aGUgc2NlbmVyeSBhbmQgdGhlIGxhaWQtYmFjayBsaWZlc3R5bGUgb2YgdGhlIGxvY2Fscy4iLCJsYW5ndWFnZXMiOiJlbiIsInNwZWNpYWx0aWVzIjoiYnVzaW5lc3MtZW5nbGlzaCxjb252ZXJzYXRpb25hbC1lbmdsaXNoLGVuZ2xpc2gtZm9yLWtpZHMsaWVsdHMsc3RhcnRlcnMsbW92ZXJzLGZseWVycyxrZXQscGV0LHRvZWZsLHRvZWljIiwicmVzdW1lIjpudWxsLCJyYXRpbmciOjQuMjQ3MTkxMDExMjM1OTU1LCJpc0FjdGl2YXRlZCI6dHJ1ZSwiaXNOYXRpdmUiOm51bGwsImNyZWF0ZWRBdCI6IjIwMjEtMDgtMDJUMTQ6MDM6MzYuMzIwWiIsInVwZGF0ZWRBdCI6IjIwMjMtMDUtMDNUMTU6MzU6NTQuMjQyWiJ9LCJyZXF1aXJlTm90ZSI6bnVsbCwibGV2ZWwiOiJISUdIRVJfQkVHSU5ORVIiLCJpc1Bob25lQWN0aXZhdGVkIjpudWxsLCJ0aW1lem9uZSI6Nywic3R1ZHlTY2hlZHVsZSI6IjEyMzQ1NjciLCJjYW5TZW5kTWVzc2FnZSI6ZmFsc2V9LCJpc1R1dG9yIjpmYWxzZSwic3RhcnRUaW1lIjoxNjgzMjEwNjAwMDAwLCJlbmRTZXNzaW9uIjoxNjgzMjEyMTAwMDAwLCJ0aW1lSW5Sb29tIjoxODAwLCJib29raW5nSWQiOiI4OGNiNGFmZS1iMzc2LTQ2OGItOGFkYS1jNzM1MTlmNzJhZmUiLCJpYXQiOjE2ODMyMDk3MDAsImV4cCI6MTY4MzIyNjQ5OSwiYXVkIjoibGl2ZXR1dG9yIiwiaXNzIjoibGl2ZXR1dG9yIiwic3ViIjoiaHR0cHM6Ly9tZWV0LnR1dG9yaW5nLmxldHN0dWR5LmlvIn0.tRavpFrC078S8g5QcYdafg84eoNs_r894MDHcQ-0B1A');

                          // JitsiMeetingOptions options = JitsiMeetingOptions(roomNameOrUrl:'$userId-${_upComing?.scheduleDetailInfo!.scheduleInfo!.tutorInfo!.userId}', serverUrl: "https://meet.lettutor.com/", token: _upComing?.studentMeetingLink?.split('token=')[1]);
                          await JitsiMeetWrapper.joinMeeting( options: options);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/join.svg",
                              semanticsLabel: 'Logo join',
                              width: 10,
                              height: 10,
                            ),
                            gapW2,
                            const Text('Join', style: TextStyle(fontSize: Sizes.p16))],),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 24),
                    child:
                    Text(
                      _convertTotalLessonTime(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: Sizes.p12, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
            //   child: Text(
            //     'Select available tutoring time',
            //     textAlign: TextAlign.left,
            //     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // ConstrainedBox(
            //   constraints: const BoxConstraints(maxWidth: 400),
            //   child: Padding(
            //     padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
            //     child: Column(
            //       children:  [
            //         ConstrainedBox(
            //           constraints:const BoxConstraints(maxWidth: 200),
            //           child: Expanded(
            //             child: TextField(
            //               decoration: InputDecoration(
            //                 contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            //                 hintText: "select a day",
            //                 hintStyle: TextStyle(color: Colors.grey[400]),
            //                 border: const OutlineInputBorder(
            //                     borderSide: BorderSide(color: Colors.grey, width: 2),
            //                     borderRadius: BorderRadius.all(Radius.circular(20))),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            gapH4,
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),

              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Recommended Tutors',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.tutors,
                            (route) => false,
                      );
                    },
                      child: const Text(
                        'See all',
                        style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal, color: Colors.blueAccent),
                      ),
                  ),
                ],
              ),
            ),
            gapH4,
            Padding(
              padding: const  EdgeInsets.fromLTRB(12, 20, 12, 12),
              child: Container(
                height: 1,
                decoration:  BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child:  !checkData
                  ?
              const Text(
                'LOADING...',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.blue),
              )
                  :
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 0),
                child:  Wrap(
                  spacing: 8,
                  runSpacing: -4,
                  children: List<Widget>.generate(
                      listTutor.length,
                          (index) => CardTutor(tutor: listTutor[index],)
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
