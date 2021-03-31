import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/entities/constant.dart';
import 'package:tetris/providers/_providers.dart';
import 'package:tetris/providers/game_provider.dart';

///Our GamePage
class GamePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = useProvider(providerGameProvider);
    final game = useProvider(providerGameProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tetris-Test',
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Flex(
            direction: Axis.vertical,
            children: [..._buildRows(context, gameProvider)],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: gameProvider.spawnShape,
      ),
    );
  }

  List<Widget> _buildRows(BuildContext context, GameProvider gameProvider) {
    final list = <Widget>[];
    final activeShapeX = gameProvider.getActiveShapePositionsX();
    final activeShapeY = gameProvider.getActiveShapePositionsY();
    int posInList;
    for (var y = Constant.numRows - 1; y >= 0; y--) {
      for (var x = 0; x < Constant.numCols; x++) {
        list.add(
          Container(
            decoration: BoxDecoration(
                border: const Border(top: BorderSide(), left: BorderSide()),
                color: gameProvider.getInactiveShapeColor(x, y)),
            child: const Center(child: Text('X')),
          ),
        );
      }
    }
    if (activeShapeY != null && activeShapeX != null)
      for (var i = 0; i < activeShapeY.length; i++) {
        posInList = activeShapeX[i] * Constant.numRows + activeShapeX[i];
        list[posInList] = Container(
          decoration: BoxDecoration(
              border: const Border(top: BorderSide(), left: BorderSide()),
              color: gameProvider.getActiveShapeColor(
                  activeShapeX[i], activeShapeX[i])),
          child: const Center(child: Text('X')),
        );
      }

    return list;
  }
}
