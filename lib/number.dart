
import 'package:flutter/material.dart';

class Number extends StatelessWidget{

  @override
  @override
  Widget build(BuildContext context) {
    const fontSize = 15.0;

    return Stack(
      children: [
        Transform.translate(
          offset: Offset(0.0, -90.0),
          child: Text(
            '12',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Transform.translate(
          offset: Offset(90.0, 0.0),
          child: Text(
            '3',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, 90.0),
          child: Text(
            '6',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(-90.0, 0.0),
          child: Text(
            '9',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}