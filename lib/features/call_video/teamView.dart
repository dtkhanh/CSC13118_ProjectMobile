import 'dart:async';
import 'package:flutter/material.dart';

import '../homepage/widgets/viewCountDownTimer.dart';

class TeamView extends StatefulWidget {
  final int startTime;
  const TeamView({super.key, required this.startTime});

  @override
  State<TeamView> createState() => _TeamViewPage();
}

class _TeamViewPage extends State<TeamView> {
  late int countsecond;
  late Timer _timer;
  int _remainingTime = 0;


  @override
  void initState() {
    super.initState();
    countsecond = 0;
    startTimer();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  void startTimer() {
    _remainingTime = widget.startTime;
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _remainingTime -= 1000;
        if (_remainingTime <= 0) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int seconds = (_remainingTime / 1000).ceil();
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
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                              children: [
                                const Text("Lession start in" , style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 50,),
                                SizedBox(
                                  height: 200,
                                  width: 200,
                                  child:  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
                                      elevation: 0,
                                      primary: Colors.deepPurple,
                                    ),
                                    child: CountdownTimer(startTime: widget.startTime),
                                  ),
                                ),
                                Text(
                                  seconds > 0 ? '$seconds' : 'Countdown is over!',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ],
                            )
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
        ],
      ),
    );
  }
}