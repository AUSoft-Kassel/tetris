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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tetris-Test",
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Flex(
            direction: Axis.vertical,
            children: [...buildRows(context, gameProvider)],
          ),
        ),
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
            decoration: BoxDecoration(border: Border(top: BorderSide(), left: BorderSide()), color: gameProvider.getShapeColor(x, y) ?? Colors.grey),
            child: Center(child: Text("X")),
          ),
        );
      }
    }
    return list;
  }
}
