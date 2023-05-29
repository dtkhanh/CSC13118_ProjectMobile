import 'package:csc13118_mobile/features/homepage/widgets/viewCountDownTimer.dart';
import 'package:csc13118_mobile/features/tutors/widget/cardTutor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/appSizes.dart';
import '../../data/language.dart';
import '../../model/schedule/bookingInfo.dart';
import '../../model/tutor/tutor.dart';
import '../../routing/routes.dart';
import '../../services/tutorService.dart';
import '../../services/userService.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

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
  Language lag = Language(id: "en-US");

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    final language = prefs.getString('setLanguage')?? "en-US";
    setState(() {
      language =="en-US" ? lag = Language(id: "en-US"): lag = Language(id: "vi-Vn");
    });
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
      return lag.youHaveNotAttended;
    }
    String result = lag.Totallessontime;
    final int hour = _totalCall ~/ 60;
    final int minute = _totalCall - hour * 60;
    result += hour > 0 ? ' $hour ${hour > 1 ? 'hours' : 'hour'}' : '';
    result += minute > 0 ? ' $minute ${minute > 1 ? 'minutes' : 'minute'}' : '';
    return result;
  }
  bool isTimeToJoin() {
    final startTimestamp = _upComing?.scheduleDetailInfo?.startPeriodTimestamp ?? 0;
    final startTime = DateTime.fromMillisecondsSinceEpoch(startTimestamp);
    final now = DateTime.now();
    return now.isAfter(startTime) || now.isAtSameMomentAs(startTime);
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
                  _upComing == null?
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'You have no upcoming lesson',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Sizes.p20, color: Colors.white),
                    ),
                  )
                  :
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      lag.Upcoming,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: Sizes.p20, color: Colors.white),
                    ),
                  ),

                  _upComing == null?
                  const Text(
                    '',
                  )
                      :
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${DateFormat.yMMMEd().format(DateTime.fromMillisecondsSinceEpoch(_upComing?.scheduleDetailInfo!.startPeriodTimestamp ?? 0))} ',
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: Sizes.p16, color: Colors.white),
                          ),
                          gapW4,
                          CountdownTimer(startTime: _upComing?.scheduleDetailInfo!.startPeriodTimestamp ?? 0),
                          gapW4,
                        ],
                      ),
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
                          final String meetingToken = _upComing?.studentMeetingLink?.split('token=')[1] ?? '';
                          Map<String, dynamic> jwtDecoded = JwtDecoder.decode(meetingToken);
                          final String room = jwtDecoded['room'];
                            JitsiMeetingOptions options = JitsiMeetingOptions(
                              roomNameOrUrl: room,
                              serverUrl: "https://meet.lettutor.com/",
                              token: meetingToken,
                              isAudioMuted: false,
                              isVideoMuted: false,
                              isAudioOnly: false,
                            );
                            await JitsiMeetWrapper.joinMeeting( options: options);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/join.svg",
                              semanticsLabel: 'Logo join',
                              width: 20,
                              height: 20,
                            ),
                            gapW8,
                            Text(lag.join, style: const TextStyle(fontSize: Sizes.p16))],),
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
                  Text(
                    lag.recommendedTutors,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.tutors,
                            (route) => false,
                      );
                    },
                      child: Text(
                        lag.seeAll,
                        style: const TextStyle(fontSize: 18, fontStyle: FontStyle.normal, color: Colors.blueAccent),
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
              Text(
                lag.loading,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, color: Colors.blue),
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
