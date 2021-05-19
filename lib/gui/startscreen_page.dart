import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tetris/gui/game_page.dart';
import 'package:tetris/gui/settings_page.dart';

void main() {
  runApp(StartScreen());
}

/// Startscreen
class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MyStartScreen(),
        debugShowCheckedModeBanner: false,
      );
}

/// Startscreen
class MyStartScreen extends StatefulWidget {
  @override
  StartScreenState createState() => StartScreenState();
}

///Duration for Splashscreen
class StartScreenState extends State<MyStartScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen())));
  }

  @override
  Widget build(BuildContext context) => Container(
      color: Colors.yellow,
      child: FlutterLogo(size: MediaQuery.of(context).size.height));
}

/// Homescreen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Welcome to Tetris')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GamePage()));
                  },
                  child: const Text(
                    'Start Game',
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                  child: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
