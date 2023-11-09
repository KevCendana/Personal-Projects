import 'package:flutter/material.dart';
import 'dart:math' as math;

class Slime extends StatelessWidget{
  final int slimeSpriteCount;
  final String slimeDirection;
  Slime({required this.slimeSpriteCount, required this.slimeDirection});
  @override
  Widget build(BuildContext context) {
    if (slimeDirection == 'left') {
      return Container (
        alignment: Alignment.bottomCenter,
        height: 75,
        width: 75,
        child: Image.asset('lib/images/enemies/slime/slime_walk$slimeSpriteCount.png')
      );
    } else {
      return Transform (
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi),
        child: Container (
          alignment: Alignment.bottomCenter,
          height: 75,
          width: 75,
          child: Image.asset('lib/images/enemies/slime/slime_walk$slimeSpriteCount.png')
        )
      );
    }
  }
}