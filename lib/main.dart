import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/gui/game_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

///Our App
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GamePage(),
    );
  }
}
