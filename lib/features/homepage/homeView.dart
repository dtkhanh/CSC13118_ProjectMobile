import 'package:csc13118_mobile/features/tutors/widget/cardTutor.dart';
import 'package:csc13118_mobile/features/homepage/widgets/viewJoin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/appSizes.dart';
import '../../model/tutor/tutor.dart';
import '../../routing/routes.dart';
import '../../services/tutorService.dart';
import '../../services/userService.dart';
import '../call_video/teamView.dart';

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


  Future<void> _initPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? check =  prefs.getString('accessToken');
    getListTutor(check!);
  }
  void getTotalCall() async {
    try{
      final prefs = await SharedPreferences.getInstance();
      String? check =  prefs.getString('accessToken');
      _total = await UserService.getTotalCall(token: check!);
      if (mounted) {
        setState(() {
          checkData = true;
          _totalCall = int.parse(_total!["total"].toString());
        });
      }
      print("getTotalCall");
      print(_totalCall);
    }catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error Login: ${e.toString()}')),
      );
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '2023-03-11  20:00-00:00',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: Sizes.p16, color: Colors.white),
                      ),
                      const  Text(
                        ' ( Start in 65:43:51 ) ',
                        style: TextStyle(fontStyle: FontStyle.normal, fontSize: Sizes.p12, color: Colors.yellow),
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
                        onPressed: () {  Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const TeamView()),
                        ); },
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
                    padding: EdgeInsets.only(top: 12, bottom: 24),
                    child:
                    Text(
                      _convertTotalLessonTime(),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: Sizes.p12, color: Colors.white),
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