import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/direction.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/providers/_providers.dart';
import 'package:tetris/providers/game_provider.dart';

class SettingsPage extends HookWidget {
  ///@Override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'SETTINGS',
          style: TextStyle(
            fontSize: 33,
            color: Colors.blue[600],
            shadows: <Shadow>[
              Shadow(
                offset: Offset(5, 5),
                blurRadius: 3.0,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              Shadow(
                offset: Offset(5, 5),
                blurRadius: 8.0,
                color: Color.fromARGB(125, 0, 0, 255),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blue, Colors.deepPurple])),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://images.pexels.com/photos/3279307/pexels-photo-3279307.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100, left: 33),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(255, 155, 0, 1),
                      ),
                      color: Color.fromRGBO(255, 155, 0, 0.2),
                    ),
                    child: Text(
                      'SOUNDS',
                      style: TextStyle(fontSize: 33),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 33, left: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromRGBO(255, 155, 0, 1),
                      ),
                      color: Color.fromRGBO(255, 155, 0, 0.2),
                    ),
                    child: Text(
                      'MUSIC',
                      style: TextStyle(fontSize: 33),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
