import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maplestory_app/button.dart';
import 'package:maplestory_app/slime.dart';
import 'package:maplestory_app/player.dart';

// boy @ 25 min in video 
// https://www.youtube.com/watch?v=TFrzjwJuDiI&t=130s&ab_channel=MitchKoko
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(); // => is a shorthand for { return _MyHomePageState(); }
}


class _HomePageState extends State<HomePage> {

  //Loading Screen
  var loadingScreenColor = Color.fromARGB(255, 142, 221, 254);
  var loadingScreenTextColor = Colors.black;
  var loadingTime = 3;

  // Player
  int playerSpriteCount = 1; // initially
  double playerPosX = -0.5;
  String playerDirection = 'left';
  int attackPlayerSpriteCount = 0;

  // Slime
  int slimeSpriteCount = 1; // initially
  double slimePosX = 0.5;
  String slimeDirection = 'left';

  void startGame() {
    startGameTimer();
    moveSlime();
  }

  void startGameTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        loadingTime--;
      });
      if (loadingTime == 0) {
        setState(() {
          loadingScreenColor = Colors.transparent;
          loadingTime = 3;
          loadingScreenTextColor = Colors.transparent;
        });
        timer.cancel();
      }
    });
  }

  void moveSlime() {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        slimeSpriteCount++;
        if (slimeDirection == 'left') {
          slimePosX -= 0.01;
        } else {
          slimePosX += 0.01;
        }

        // Change direction if Slime is at the edge
        if (slimePosX < 0.3) {
          slimeDirection = 'right';
        } else if (slimePosX > 0.6) {
          slimeDirection = 'left';
        }
        if (slimeSpriteCount >= 8) {
          slimeSpriteCount = 1;
        }
      });
    });
  }

  void moveLeft() {
    setState(() {
      playerSpriteCount++;
      playerPosX -= 0.03;
      playerDirection = 'left';
      if (playerSpriteCount >= 5) {
        playerSpriteCount = 1;
      }
    });
  }

  void moveRight() {
    setState(() {
      playerSpriteCount++;
      playerPosX += 0.03;
      playerDirection = 'right';
      if (playerSpriteCount >= 5) {
        playerSpriteCount = 1;
      }
    });
  }

  void attack() {
    Timer.periodic(Duration(milliseconds: 350), (timer) {
        setState(() {
          print('player attacked');
          attackPlayerSpriteCount++;
        });
        if (attackPlayerSpriteCount >= 3) {
          if (playerDirection == 'right' && playerPosX + 0.2 > slimePosX) {
            print('hit');
          } else {
            attackPlayerSpriteCount = 0;
            timer.cancel();
          }
        }
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold (
        // Body is a column with 3 components: sky, grass, and ground
        body: Column (
          children: [
            // Sky, Expanded is a widget that takes up as much space as possible
            Expanded (
              flex: 3,
              child: Container (
                    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("lib/images/environment/background.jpg"), // Replace with your image asset
        fit: BoxFit.cover, // This will cover the entire container space without stretching the image
      ),
    ),
                child: Stack (
                  children: [
                    Container(
                      alignment: Alignment(slimePosX, 1),
                      child: Slime(slimeSpriteCount: slimeSpriteCount, slimeDirection: slimeDirection)
                      ),
                    Container(
                      alignment: Alignment(playerPosX, 1),
                      child: Player(
                        playerSpriteCount: playerSpriteCount, 
                        playerDirection: playerDirection,
                        attackBoySpriteCount: attackPlayerSpriteCount,
                      )
                    ),
                    Container (
                      color: loadingScreenColor,
                      child: Center (
                        child: Text(
                          loadingTime.toString(),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: loadingScreenTextColor
                          ),
                          )
                          
                      )
                    )
                  ]
                )
              ),
            ),
            // Ground
            Expanded (
              child: Container (
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/images/environment/ground.jpg"), // Replace with your image asset
                        fit: BoxFit.cover, // This will cover the entire container space without stretching the image
                      ),
                    ),
                // Title and buttons
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('M a p l e s t o r y', style: TextStyle(color: Colors.white)),
                    Row (
                      children: [
                        MyButton(
                          text: 'Play', 
                          function: () {
                            startGame();
                          }
                        ),
                        MyButton(text: 'Attack', function: () {
                          attack();
                        }),
                        MyButton(text: '←', function: () {
                          moveLeft();
                        }),
                        MyButton(text: '↑', function: () {
                          //jump();
                        }),
                        MyButton(text: '→ ', function: () {
                          moveRight();
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]
        )
      );
  }
}

