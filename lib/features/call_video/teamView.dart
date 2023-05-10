import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeamView extends StatefulWidget {
  const TeamView({Key? key}) : super(key: key);

  @override
  State<TeamView> createState() => _TeamViewPage();
}

class _TeamViewPage extends State<TeamView> {
  late int _secondsLeft;
  late int countsecond;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _secondsLeft = 900;
    countsecond = 0;
    startTimer();
    CoundTimer();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsLeft > 0) {
          _secondsLeft--;
        } else {
          _timer.cancel();
        }
      });
    });
  }
  void CoundTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (countsecond >= 0) {
          countsecond++;
        } else {
          _timer.cancel();
        }
      });
    });
  }
  String getFormattedTime() {
    int minutes = (_secondsLeft / 60).floor();
    int seconds = _secondsLeft % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  String getFormattedTimeCount() {
    int minutes = (countsecond / 60).floor();
    int seconds = countsecond % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.blue[600],
        ),
        title: Text(
          'Meeting',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            //letterSpacing: 1.0,
            color: Colors.blue[600],
          ),
        ),
      ),
      body: Column(
        children: [
              Expanded(
                  child: Container(
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Stack(
                      children: [
                        Text(getFormattedTimeCount(), style: const TextStyle( color: Colors.red, fontSize: 25),),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: 200,
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
                                elevation: 0,
                                primary: Colors.deepPurple,
                              ),
                              child: Text(getFormattedTime(), style: TextStyle( color: Colors.white, fontSize: 50
                              ),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // child: Container(
                  //   color: Colors.black54,
                  //   child:  Text(
                  //     getFormattedTime(),
                  //   ),
                  // )
              ),
              Container(
                color: Colors.black54,
                child: SizedBox(
                  width: 300,
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your onPressed code here
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            elevation: 0,
                            primary: Colors.black,
                          ),
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: SvgPicture.asset(
                              "assets/svg/ic_micro.svg", color: Colors.white,
                              semanticsLabel:
                              'Logo Icon', height: 30, width: 30,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child:  ElevatedButton(
                          onPressed: () {
                            // Add your onPressed code here
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            elevation: 0,
                            primary: Colors.black,
                          ),
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: SvgPicture.asset(
                              "assets/svg/icon_camera.svg", color: Colors.white,
                              semanticsLabel:
                              'Logo Icon',height: 30, width: 30,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child:  ElevatedButton(
                          onPressed: () {
                            // Add your onPressed code here
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            elevation: 0,
                            primary: Colors.black,
                          ),
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: SvgPicture.asset(
                              "assets/svg/ic_shareDesk.svg", color: Colors.white,
                              semanticsLabel:
                              'Logo Icon',height: 30, width: 30,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child:  ElevatedButton(
                          onPressed: () {
                            // Add your onPressed code here
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            elevation: 0,
                            primary: Colors.black,
                          ),
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: SvgPicture.asset(
                              "assets/svg/ic_chat.svg", color: Colors.white,
                              semanticsLabel:
                              'Logo Icon',height: 30, width: 30,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child:   ElevatedButton(
                          onPressed: () {
                            // Add your onPressed code here
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            elevation: 0,
                            primary: Colors.black,
                          ),
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: SvgPicture.asset(
                              "assets/svg/ic_hand.svg", color: Colors.white,
                              semanticsLabel:
                              'Logo Icon',height: 30, width: 30,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your onPressed code here
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            elevation: 0,
                            primary: Colors.black,
                          ),
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: SvgPicture.asset(
                              "assets/svg/ic_frame.svg", color: Colors.white,
                              semanticsLabel:
                              'Logo Icon',height: 30, width: 30,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child:  ElevatedButton(
                          onPressed: () {
                            // Add your onPressed code here
                          },
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                            elevation: 0,
                            primary: Colors.red,
                          ),
                          child:Padding(
                            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: SvgPicture.asset(
                              "assets/svg/ic_call.svg", color: Colors.white,
                              semanticsLabel:
                              'Logo Icon',height: 30, width: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}