
import 'package:flutter/material.dart';

class Hand extends StatelessWidget{


  const Hand({
    required this.color,
    required this.size,
    required this.angleRadians,
    required this.child,
  });

  final Color color;
  final double size;
  final double angleRadians;
  final Widget child;

  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: Transform.rotate(
          angle: angleRadians,
          alignment: Alignment.center,
          child: Transform.scale(
            scale: size,
            alignment: Alignment.center,
            child: Container(
              color: color,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}