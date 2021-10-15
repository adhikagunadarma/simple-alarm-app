
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
// import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;


import 'hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

/// A basic analog clock.
///
/// You can do better than this!
class AnalogClock extends StatefulWidget {
  const AnalogClock();

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final customTheme = Theme.of(context).brightness == Brightness.light
        ? Theme.of(context).copyWith(
      // Hour hand.
      primaryColor: Colors.black,
      // Minute hand.
      highlightColor: Colors.black,
      // BG Clock
      backgroundColor: Colors.white,
    )
        : Theme.of(context).copyWith(
      primaryColor: Colors.white,
      highlightColor: Colors.white,
      accentColor: Colors.white,
      backgroundColor: Colors.black,
    );

    // final time = DateFormat.Hms().format(DateTime.now());
    // final weatherInfo = DefaultTextStyle(
    //   style: TextStyle(color: customTheme.primaryColor),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(_temperature),
    //       Text(_temperatureRange),
    //       Text(_condition),
    //       Text(_location),
    //     ],
    //   ),
    // );

    return Semantics.fromProperties(
      properties: SemanticsProperties(
        label: 'Analog clock with time ',
        value: 'time',
      ),
      child: Container(
        decoration: new BoxDecoration(
            color: customTheme.backgroundColor,
            shape: BoxShape.circle,
            border: Border.all(color: customTheme.primaryColor, width: 5.0)),
//        color: customTheme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Example of a hand drawn with [CustomPainter].

              // min
              Hand(
                color: Colors.transparent,
                size: 0.5,
                angleRadians: _now.minute * radiansPerTick +
                    (_now.second / 60) * radiansPerTick,
                child: Transform.translate(
                  offset: Offset(0.0, -130.0),
                  child: Container(
                    width: 10,
                    height: 250,
                    decoration: BoxDecoration(
                      color: customTheme.highlightColor,
                    ),
                  ),
                ),
              ),
              // Example of a hand drawn with [Container].
              // hour
              Hand(
                color: Colors.transparent,
                size: 0.5,
                angleRadians: _now.hour * radiansPerHour +
                    (_now.minute / 60) * radiansPerHour,
                child: Transform.translate(
                  offset: Offset(0.0, -70.0),
                  child: Container(
                    width: 16,
                    height: 150,
                    decoration: BoxDecoration(
                      color: customTheme.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}