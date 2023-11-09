import 'dart:math';
import 'package:flutter/material.dart';

class Player extends StatelessWidget {
  final int playerSpriteCount;
  final int attackBoySpriteCount;
  final String playerDirection;
  Player({ 
    required this.playerSpriteCount,
    required this.playerDirection,
    required this.attackBoySpriteCount 
  });

  @override
  Widget build(BuildContext buildContext) {
      int directionAsInt = 1;

      if (playerDirection == 'left') {
        directionAsInt = 0;
      } else if (playerDirection == 'right') {
        directionAsInt = 1;
      } else {
        directionAsInt = 0;
      }


      if (attackBoySpriteCount == 0) {
        return Container(
          child: Transform (
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi*directionAsInt),
            child: Container (
              alignment: Alignment.bottomCenter,
              height: 100,
              width: 100,
              child: Stack (
                children: [ 
                  Image.asset(
                    'lib/images/players/kev/walk1_${playerSpriteCount}.png',
                  ),

                ]
              ),
            ),  
          ),
        );
      } else {
        print('attack detected');
        return Container(
          child: Transform (
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi*directionAsInt),
            child: Container (
              alignment: Alignment.bottomCenter,
              height: 100,
              width: 100,
              child: Image.asset(
                'lib/images/players/kev/swingO1_${attackBoySpriteCount}.png',
              ),
            ),  
          ),
        );
      }
    }
}