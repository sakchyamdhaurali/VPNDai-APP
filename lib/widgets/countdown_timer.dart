import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final bool startTimer;

  const CountdownTimer({Key? key, required this.startTimer}) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Duration _duration = Duration();
  Timer? _timer;

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds + 1);
      });
    });
  }

  _stopTimer() {
    setState(() {
      _timer?.cancel();
      _timer = null;
      _duration = Duration();
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_timer==null|| !widget.startTimer)

    widget.startTimer ? _startTimer() : _stopTimer();

    String twodigit(int n) => n.toString().padLeft(2, '0');
    final minutes = twodigit(_duration.inMinutes.remainder(60));
    final seconds = twodigit(_duration.inSeconds.remainder(60));
    final hours = twodigit(_duration.inHours.remainder(60));

    return Text(
      '$hours: $minutes: $seconds',
      style: TextStyle(
        fontSize: 22,
      ),
    );
  }
}
