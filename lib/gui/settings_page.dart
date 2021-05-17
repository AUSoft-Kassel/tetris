import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Displays page for user settings
class SettingsPage extends HookWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'SETTINGS',
            style: TextStyle(
              fontSize: 33,
              color: Colors.blue[600],
              shadows: <Shadow>[
                const Shadow(
                  offset: Offset(5, 5),
                  blurRadius: 3.0,
                  //color: Color.fromARGB(255, 0, 0, 0),
                ),
                const Shadow(
                  offset: Offset(5, 5),
                  blurRadius: 8.0,
                  color: Color.fromARGB(125, 0, 0, 255),
                ),
              ],
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.blue, Colors.deepPurple])),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.pexels.com/photos/3279307/pexels-photo-3279307.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260'),
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
                          color: const Color.fromRGBO(255, 155, 0, 1),
                        ),
                        color: const Color.fromRGBO(255, 155, 0, 0.2),
                      ),
                      child: const Text(
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
                          color: const Color.fromRGBO(255, 155, 0, 1),
                        ),
                        color: const Color.fromRGBO(255, 155, 0, 0.2),
                      ),
                      child: const Text(
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
