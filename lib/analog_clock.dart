
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;


import 'hand.dart';

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);
/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

class AnalogClock extends StatefulWidget {
  const AnalogClock();

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  var _now = DateTime.now();
  var _alarm;
  var _alarmRinging  = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    var _alarmHour = 14;
    var _alarmMinute = 09;
    _alarm = new DateTime(_now.year, _now.month, _now.day, _alarmHour, _alarmMinute, 0, 0, 0);

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
      backgroundColor: Colors.black,
    );

    final time = DateFormat.Hm().format(DateTime.now());
    final alarm = DateFormat.Hm().format(_alarm);

    setState(() {
      if (time == alarm){
          this._alarmRinging = true;
      }
    });

    return MaterialApp(
      title : "Simple Alarm Clock",
      home : new Scaffold(
        //Here you can set what ever background color you need.
        backgroundColor: customTheme.backgroundColor,
        body:  Center(
            child: Column(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text('Next Alarm at : $alarm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                            // min
                            Hand(
                              color: Colors.transparent,
                              size: 0.5,
                              angleRadians: _now.minute * radiansPerTick +
                                  (_now.second / 60) * radiansPerTick,
                              child: Transform.translate(
                                offset: Offset(0.0, -90.0),
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
                  ),
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(time,
                        textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),),

                  ),
                ),)
              ],
            ),
          ),

      ),
    );
  }
}