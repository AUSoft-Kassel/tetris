import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/entities/constant.dart';
import 'package:tetris/providers/_providers.dart';
import 'package:tetris/providers/game_provider.dart';

import 'dart:developer';

class GamePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = useProvider(providerGameProvider);
    final game = useProvider(providerGameProvider.state);
    log('Sreen build running');

    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: Flex(
          mainAxisSize: MainAxisSize.min,
          direction: Axis.vertical,
          children: [
            // Zeile für Grid bzw Highscore etc
            LayoutBuilder(
              builder: (context, constraints) {
                var maxX = (constraints.maxWidth * 2 / 3);
                var block = maxX / Constant.numCols;
                return Container(
                  height: block * Constant.numRows,
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      // Grid
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Stack(
                          children: [
                            GridView.count(
                              crossAxisCount: Constant.numCols,
                              children: _buildRows(context, gameProvider),
                            )
                          ],
                        ),
                      ),
                      // Highscore etc
                      Flexible(
                        fit: FlexFit.tight,
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            Expanded(
                              child: Container(
                                color: Colors.red,
                                child: Center(
                                  child: Text('High'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.green,
                                child: Center(
                                  child: Text('Pers'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.orange,
                                child: Center(
                                  child: Text('Next'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.lime,
                                child: Center(
                                  child: Text('Level'),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.pink,
                                child: Center(
                                  child: Text('Nick'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),

            // Zeile für Befehlsbuttons etc.
            Container(
              color: Colors.blue,
              child: const Text('unten'),
            ),
          ],
        )),
      ),
    );
  }

  List<Widget> _buildRows(BuildContext context, GameProvider gameProvider) {
    log('Build a row');
    final list = <Widget>[];
    for (var y = Constant.numRows - 1; y >= 0; y--) {
      for (var x = 0; x < Constant.numCols; x++) {
        log('buildCell: $x, $y');
        list.add(
          Container(
            decoration: BoxDecoration(border: Border(top: BorderSide(), left: BorderSide()), color: gameProvider.getShapeColorAt(x, y) ?? Colors.grey),
            child: Center(child: Text("X")),
          ),
        );
      }
    }
    return list;
  }
}
