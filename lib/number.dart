
import 'package:flutter/material.dart';

class Number extends StatelessWidget{

  @override
  @override
  Widget build(BuildContext context) {
    const fontSize = 15.0;

    return Stack(
      children: [
        Transform.translate(
          offset: Offset(0.0, -MediaQuery.of(context).size.width* 0.2),
          child: Text(
            '12',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Transform.translate(
          offset: Offset(MediaQuery.of(context).size.width* 0.2, 0.0),
          child: Text(
            '3',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0.0, MediaQuery.of(context).size.width* 0.2),
          child: Text(
            '6',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(-MediaQuery.of(context).size.width* 0.2, 0.0),
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