import 'package:flutter/material.dart';
import 'package:simple_alarm_analog_clock/analog_clock.dart';
import 'package:simple_alarm_analog_clock/service/NotificationService.dart';

Future<void> main() async{

  await NotificationService().init();
  runApp(MaterialApp(home: AnalogClock()));
}
