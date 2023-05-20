import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int startTime;

  const CountdownTimer({super.key, required this.startTime});

  @override
  State<CountdownTimer> createState() => _CountdownTimerStage();

}

class _CountdownTimerStage extends State<CountdownTimer> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(widget.startTime);
    Duration difference = _currentTime.difference(startTime);
    bool isNegative = difference.isNegative;
    difference = difference.abs();
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);
    String formattedTime =
        '${isNegative ? "" : ""}${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    return Text(
      formattedTime,
      style: const TextStyle(fontStyle: FontStyle.normal, fontSize: 14, color: Colors.yellow),
    );
  }
}