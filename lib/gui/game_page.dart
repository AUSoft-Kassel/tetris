import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/direction.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/providers/_providers.dart';
import 'package:tetris/providers/game_provider.dart';

///Our GamePage
class GamePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = useProvider(providerGameProvider.notifier);
    final game = useProvider(providerGameProvider);

    return Material(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: LayoutBuilder(builder: (context, constraints) {
              final maxX = constraints.maxWidth;
              final maxY = constraints.maxHeight;
              final gridSizeX = maxX * 3 / 4;
              final gridSizeY = maxY * 4 / 5;
              final sidebarSizeX = maxX - gridSizeX;
              final bottomSizeY = maxY - gridSizeY;
              final double blockSize;
              if (gridSizeX / Constant.numCols < gridSizeY / Constant.numRows)
                blockSize = gridSizeX / Constant.numCols;
              else
                blockSize = gridSizeY / Constant.numRows;
              return Stack(children: [
                Flex(
                  direction: Axis.vertical,
                  children: [
                    // Oberer Bereich
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        //Grid
                        Container(
                          height: gridSizeY,
                          width: gridSizeX,
                          color: Colors.amber,
                          child: Stack(
                            children: [
                              ..._buildRows(context: context, gameProvider: gameProvider, blockSize: blockSize),
                              ..._buildActiveShape(context: context, gameProvider: gameProvider, blockSize: blockSize),
                            ],
                          ),
                        ),

                        //Sidebar
                        Container(
                          width: sidebarSizeX,
                          height: gridSizeY,
                          color: Colors.green,
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              _sidebarBox('Highscore'),
                              _sidebarBox('Personal score'),
                              _sidebarBox('Next Shape'),
                              _sidebarBox('Lvl/Speed'),
                              _sidebarBox('Nickname'),
                            ],
                          ),
                        )
                      ],
                    ),

                    ///Button
                    Container(
                        height: bottomSizeY,
                        color: Colors.black,
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  // Expanded(
                                  //   child: Container(
                                  //     color: Colors.blue,
                                  //   ),
                                  // ),
                                  _buttonBox(
                                    gameProvider,
                                    alignment: const Alignment(-0.8, -0.75),
                                    icon: Icons.keyboard_arrow_left_rounded,
                                    size: bottomSizeY / 2,
                                    direction: Direction.left,
                                  ),
                                  _buttonBox(
                                    gameProvider,
                                    alignment: const Alignment(0.8, -0.75),
                                    icon: Icons.keyboard_arrow_right_rounded,
                                    size: bottomSizeY / 2,
                                    direction: Direction.right,
                                  ),
                                  _buttonBox(
                                    gameProvider,
                                    alignment: const Alignment(0, 0.6),
                                    icon: Icons.keyboard_arrow_down_rounded,
                                    size: bottomSizeY / 2,
                                    direction: Direction.down,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  // Expanded(
                                  //   child: Container(
                                  //     color: Colo.yellow,
                                  //   ),
                                  // ),
                                  _buttonBox(
                                    gameProvider,
                                    alignment: const Alignment(-0.75, 0.6),
                                    icon: Icons.rotate_left_rounded,
                                    size: bottomSizeY / 2.25,
                                    rotation: Rotation.left,
                                  ),
                                  _buttonBox(
                                    gameProvider,
                                    alignment: const Alignment(0.75, -0.6),
                                    icon: Icons.rotate_right_rounded,
                                    size: bottomSizeY / 2.25,
                                    rotation: Rotation.right,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
                if (!game.gameRunning)
                  Center(
                      child: TextButton(
                    onPressed: () {
                      gameProvider.startGame();
                    },
                    child: Container(
                        color: Colors.blue,
                        child: const Text('Start Game',
                            style: TextStyle(
                              color: Colors.black87,
                              backgroundColor: Colors.blue,
                            ))),
                  ))
              ]);
            })));
  }

  List<Widget> _buildRows({required BuildContext context, required GameProvider gameProvider, required double blockSize}) {
    final list = <Widget>[];
    final grid = gameProvider.state.grid;
    for (var y = Constant.numRows - 1; y >= 0; y--) {
      for (var x = 0; x < Constant.numCols; x++) {
        list.add(
          Positioned(
            bottom: blockSize * y,
            left: blockSize * x,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: gameProvider.getInactiveShapeColor(x, y),
              ),
              height: blockSize,
              width: blockSize,
            ),
          ),
        );
      }
    }
    return list;
  }

  List<Widget> _buildActiveShape({required BuildContext context, required GameProvider gameProvider, required double blockSize}) {
    final list = <Widget>[];
    final positions = gameProvider.getActiveShapePositions();
    log('$positions');
    for (var pos in positions) {
      if (pos.y < Constant.numRows) {
        list.add(
          Positioned(
            bottom: blockSize * pos.y,
            left: blockSize * pos.x,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: Color(gameProvider.state.activeShape?.color ?? Color.fromARGB(255, 255, 255, 255).value),
              ),
              height: blockSize,
              width: blockSize,
            ),
          ),
        );
      }
    }
    return list;
  }

  Widget _buttonBox(
    GameProvider gameProvider, {
    required Alignment alignment,
    required IconData icon,
    required double size,
    Direction? direction,
    Rotation? rotation,
  }) =>
      Align(
        alignment: alignment,
        child: Container(
          width: size,
          height: size,
          child: GestureDetector(
            onTap: () {
              if (direction != null) {
                log('Button: Direction: ${direction}');
                gameProvider.moveShape(direction);
              } else if (rotation != null) {
                log('Button: Rotation: ${rotation}');
                gameProvider.rotateShape(rotation);
              }
            },
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(icon, color: Colors.orange),
            ),
          ),
        ),
      );

  Widget _sidebarBox(String text) => Expanded(
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(text),
        ),
      );
}
