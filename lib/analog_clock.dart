import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import 'hand.dart';
import 'number.dart';

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
  var _alarmOff;
  var _alarmTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    var _alarmHour = 17;
    var _alarmMinute = 46;
    _alarmOff = false;
    _alarmTime = new DateTime(
        _now.year, _now.month, _now.day, _alarmHour, _alarmMinute, 0, 0, 0);


  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTime() {

    setState(() {
      // _now = DateTime.now(); ///not working anymore because the clock is customed
      setClockTick();
      _timer = Timer(
        Duration(seconds: 1),
        _updateTime,
      );
    });
  }

  void setClockTick(){
    if (_now.second == 60){
      _now = new DateTime(
          _now.year, _now.month, _now.day, _now.hour, _now.minute + 1, 0, _now.millisecond, _now.microsecond);
    }else if (_now.minute == 60){
      _now = new DateTime(
          _now.year, _now.month, _now.day, _now.hour + 1, 0, _now.second, _now.millisecond, _now.microsecond);
    }else if (_now.hour == 24){
      _now = new DateTime(
          _now.year, _now.month, _now.day, 00, _now.minute , _now.second, _now.millisecond, _now.microsecond);
    }else {
      _now = new DateTime(
          _now.year, _now.month, _now.day, _now.hour, _now.minute , _now.second + 1, _now.millisecond, _now.microsecond);
    }
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

    final time = DateFormat.Hm().format(_now);
    final alarm = DateFormat.Hm().format(_alarmTime);

    _showAlertDialog(BuildContext context) {

      // set up the button
      Widget offButton = TextButton(
        child: Text("Turn Off"),
        onPressed: () {
          Navigator.of(context).pop(); // dismiss dialog
          setState(() {
            _alarmOff = true;
          });

        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("Alarm"),
        content: Text("Alarm is Ringing!"),
        actions: [
          offButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    print(_now);

    print(alarm);
    if(time == alarm && !_alarmOff){
      // print('RINGG!');

      _showAlertDialog(context);
    }
    return new Scaffold(
        //Here you can set what ever background color you need.
        backgroundColor: customTheme.backgroundColor,
        body: Center(
          child: Column(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Next Alarm at : $alarm',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      _showAlertDialog(context);
                    },
                    onPanUpdate: (details){
                      if (details.delta.dx > 0){
                        var changes = _now.minute + (details.delta.dx / 2.5);
                        setState(() {
                            _now = new DateTime(
                                _now.year, _now.month, _now.day, _now.hour, changes.toInt(), _now.second, _now.millisecond, _now.microsecond);
                            });
                      }
                      else{
                        var changes = _now.minute + (details.delta.dx / 2.5);
                        setState(() {
                          _now = new DateTime(
                              _now.year, _now.month, _now.day, _now.hour, changes.toInt(), _now.second, _now.millisecond, _now.microsecond);
                        });
                      }
                      // //to smoothen the UI UX, set hour is disabled
                      // if (details.delta.dy > 0){
                      //   var changes = _now.hour + (details.delta.dy / 2.5);
                      //   setState(() {
                      //     _now = new DateTime(
                      //         _now.year, _now.month, _now.day, changes.toInt(), _now.minute, _now.second, _now.millisecond, _now.microsecond);
                      //   });
                      // }
                      // else{
                      //   var changes = _now.hour + (details.delta.dy / 2.5);
                      //   setState(() {
                      //     _now = new DateTime(
                      //         _now.year, _now.month, _now.day, changes.toInt(), _now.minute, _now.second, _now.millisecond, _now.microsecond);
                      //   });
                      // }
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                          color: customTheme.backgroundColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: customTheme.primaryColor, width: 5.0)),
//        color: customTheme.backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // min
                            Number(),
                            Hand(
                              color: Colors.transparent,
                              size: 0.5,
                              angleRadians: _now.minute * radiansPerTick +
                                  (_now.second / 60) * radiansPerTick,
                              child: Transform.translate(
                                offset: Offset(0.0, -70.0),
                                child: Container(
                                  width: 10,
                                  height: 150,
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
                                offset: Offset(0.0, -50.0),
                                child: Container(
                                  width: 16,
                                  height: 100,
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
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Column(
                      children: [ Text(
                        'Current Time : ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.0,
                          letterSpacing: 1.5,
                        ),
                      ),
                        Text(
                          time,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
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
