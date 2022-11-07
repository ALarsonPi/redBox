import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  int startingSeconds;
  TextStyle textStyle;
  Function timesUpFunction;
  bool shouldShowText;
  String textToShow;

  TimerWidget({
    required this.startingSeconds,
    required this.textStyle,
    required this.timesUpFunction,
    this.shouldShowText = false,
    this.textToShow = "",
  });

  @override
  State<StatefulWidget> createState() {
    return _TimerWidget();
  }
}

class _TimerWidget extends State<TimerWidget> {
  Timer? countdownTimer;
  late Duration myDuration;
  late BuildContext myContext;

  @override
  void initState() {
    super.initState();
    myDuration = Duration(seconds: widget.startingSeconds);
    startTimer();
  }

  startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds <= 0) {
        stopTimer();
        widget.timesUpFunction(myContext);
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(seconds: widget.startingSeconds));
  }

  @override
  Widget build(BuildContext context) {
    myContext = context;
    int startValue = widget.startingSeconds;
    final seconds = myDuration.inSeconds.remainder(startValue).toString();
    String textToShow =
        (seconds == '0') ? '${widget.startingSeconds}' : '$seconds';
    if (widget.shouldShowText) {
      textToShow = "${widget.textToShow}:$textToShow";
    }
    return Text(
      textToShow,
      style: widget.textStyle,
    );
  }
}
