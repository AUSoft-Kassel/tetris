import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/entities/direction.dart';
import 'package:tetris/entities/game.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shape.dart';

class GameProvider extends StateNotifier<Game> {
  GameProvider() : super(Game());

  /*--------------------------------------------------------------------------*/
  /* State setters                                                            */
  /*--------------------------------------------------------------------------*/
  void moveShape(Direction dir) {
    final shape = state.activeShape;
    final absRefPosition = state.activeShapePosition;
    if (shape == null || absRefPosition == null) return;
    final absPositions = shape.absPositions(base: absRefPosition.toPosition, direction: dir);
    for (var pos in absPositions) {}
  }

  void clearFullRow(int row) {
    final newGrid = <Position, Shape?>{};
    state.grid.forEach((pos, shape) {
      if (shape != null) {
        if (pos.y < row) {
          newGrid[pos] = shape;
        } else if (pos.y > row) {
          newGrid[Position(pos.x, pos.y - 1)] = shape;
        }
      }
    });
    state = state.copyWith(grid: newGrid);
  }

  void clearFullRows() {
    final fullRows = state.whichRowsAreFull();
    fullRows.sort((a, b) => b.compareTo(a));
    for (var row in fullRows) {
      clearFullRow(row);
    }
  }

  /*--------------------------------------------------------------------------*/
  /* State getters                                                            */
  /*--------------------------------------------------------------------------*/
  /// Get the shape at a certain position (x,y)
  /// Returns null if no shape is presen
  Shape? getShapeAt(int x, int y) => state.grid[Position(x, y)];

  /// Get color of shape at a certain position (x,y)
  /// Returns null if no shape is presen
  Color? getShapeColor(int x, int y) {
    log('getShapeColor: $x, $y');
    var col = getShapeAt(x, y)?.color;
    if (col != null) {
      log("got color");
    } else {
      log("got no color");
    }
    return col;
  }
}
