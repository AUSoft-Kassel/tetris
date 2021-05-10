import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/direction.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/providers/_providers.dart';
import 'package:tetris/providers/game_provider.dart';

///Our GamePage
class GamePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = useProvider(providerGameProvider.notifier);
    final game = useProvider(providerGameProvider);
    final _rowsToClear = useProvider(providerGameProvider).rowsToClear;

    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
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
            return Stack(
              children: [
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
                              _sidebarBox('Highscore', valueInt: 99999),
                              _sidebarBox('Personal score', valueInt: game.points),
                              _sidebarNextShape(game.shapeShop.showShape()),
                              _sidebarBox('Lvl/Speed', valueInt: game.level),
                              _sidebarBox('Nickname', valueString: 'Heinz'),
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
                      ),
                    ),
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
                        child: const Text(
                          'Start Game',
                          style: TextStyle(
                            color: Colors.black87,
                            backgroundColor: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildRows({required BuildContext context, required GameProvider gameProvider, required double blockSize}) {
    final list = <Widget>[];
    for (var y = Constant.numRows - 1; y >= 0; y--) {
      for (var x = 0; x < Constant.numCols; x++) {
        list.add(
          Positioned(
            bottom: blockSize * y,
            left: blockSize * x,
            child: AnimatedBox(
              color: gameProvider.getShapeColorAt(Position(x, y)) ?? Colors.grey[200]!,
              height: blockSize,
              width: blockSize,
              lineToClear: gameProvider.isRowToClear(y),
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
                gameProvider.moveActiveShape(direction);
              } else if (rotation != null) {
                gameProvider.rotateActiveShape(rotation);
              }
            },
            child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(icon, color: Colors.orange),
            ),
          ),
        ),
      );

  Widget _sidebarBox(String title, {String? valueString, int? valueInt, Shape? valueShape}) => Expanded(
        child: Flex(
          direction: Axis.vertical,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(title),
            ),
            if (valueString != null)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  valueString,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            if (valueInt != null)
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  valueInt.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
          ],
        ),
      );

  Widget _sidebarNextShape(Shape next) => Expanded(
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          children: _sidebarNextShapeTiles(next),
        ),
      );

  List<Widget> _sidebarNextShapeTiles(Shape next) {
    var widgets = <Widget>[];
    widgets.add(LayoutBuilder(builder: (context, constraints) {
      var maxH = constraints.maxHeight;
      var maxW = constraints.maxWidth;
      var max = maxH < maxW ? maxH : maxW;
      return Container(
        height: max,
        width: max,
        decoration: BoxDecoration(color: Colors.red),
      );
    }));
    return widgets;
  }
}

class AnimatedBox extends HookWidget {
  final double _height;
  final double _width;
  final Color _color;
  final bool _lineToClear;

  late double _opacityValue;

  AnimatedBox({required double height, required double width, required Color color, bool lineToClear = false})
      : _height = height,
        _width = width,
        _color = color,
        _lineToClear = lineToClear;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: const Duration(milliseconds: 1000));
    // animationController
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     log('Stop Animation');
    //     animationController.reset();
    //   }
    // })
    // ..addListener(() {
    //   log('Tst: ${animationController.value}');
    // });

    useValueChanged(_lineToClear, (a, dynamic b) {
      if (_lineToClear) {
        log('Start Animation: $a -> $b');
        animationController.reset();
        animationController.forward();
      }
    });

    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Center(
        child: Container(
          decoration: BoxDecoration(
            color: _lineToClear ? Colors.black.withOpacity(animationController.value) : _color,
            // _color.withOpacity(_lineToClear ? animationController.value : 1),
            border: Border.all(),
          ),
          height: _height,
          width: _width,
        ),
      ),
    );
  }
}
