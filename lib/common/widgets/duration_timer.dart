import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:find_cook/common/widgets/text_view.dart';

import '../../core/theme/pallets.dart';

class TimedText extends StatefulWidget {
  final DateTime startTime;
  final DateTime endTime;
  final String endText;
  final VoidCallback? onEnded;

  const TimedText(
      {Key? key,
      required this.startTime,
      required this.endTime,
      required this.endText,
       this.onEnded})
      : super(key: key);

  @override
  State<TimedText> createState() => _TimedTextState();
}

class _TimedTextState extends State<TimedText> {
  String _displayText = "";
  Duration remainingTime = Duration.zero;

  // late Timer timer;

  @override
  void initState() {
    super.initState();
    // startTimer();

    _updateText();
  }

  @override
  Widget build(BuildContext context) {
    return TextView(
      text: _displayText,
      style: GoogleFonts.sora(
          fontSize: 18, color: Pallets.primary, fontWeight: FontWeight.w600),
    );
  }

  void _updateText() {
    final now = DateTime.now();

    if (now.isAfter(widget.endTime.toLocal())) {
      if (widget.onEnded != null) {
        widget.onEnded!();
      }
      _displayText = widget.endText;
      remainingTime = now.difference(widget.endTime); //
      // timer.cancel(); // Set elapsed time at end
    } else if (now.isAfter(widget.startTime)) {
      remainingTime = widget.endTime.difference(now);

      final formattedTime =
          '${remainingTime.inHours} : ${(remainingTime.inMinutes % 60.round())} : ${(remainingTime.inSeconds % 60).round()}';
      _displayText = formattedTime;
    } else {
      // Before start time, display "Timer not yet started"
      _displayText = "Timer not yet started";
    }
    // Update the UI every second
    setState(() {});
    Future.delayed(const Duration(seconds: 1), () => _updateText());
  }

  // void startTimer() {
  //   // if(DateTime.now){}
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     _updateText();
  //     logger.i(widget.endTime.toIso8601String());
  //     setState(() {});
  //   });
  // }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }
}
