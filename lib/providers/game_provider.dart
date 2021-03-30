import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/entities/direction.dart';
import 'package:tetris/entities/game.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shape.dart';

/// GameProvider is a StateNotifier
/// It always hold a reference to the currently active state of the underlying
/// Game object, which is accessible through its state attribute (which is
/// defined in StateNotifier class). Upon creation, it creates a standard
/// Game object. Every change of state must be achieved through a reassignment
/// of the state attribute to a new object of type Game.
class GameProvider extends StateNotifier<Game> {
  /// Standard constructor. A Game object is created and handed to the super
  /// class where it gets stored in the state attribute.
  GameProvider() : super(Game());

  /*--------------------------------------------------------------------------*/
  /* Use cases (external): Manipulating state for external reasons            */
  /*--------------------------------------------------------------------------*/
  /// Moves a shape into Direction dir. It is usually invoked after an user input
  void moveShape(Direction dir) {
    final shape = state.activeShape;
    final absRefPosition = state.activeShapePosition;
    var newAbsRefPosition = absRefPosition;
    if (shape == null || absRefPosition == null) return;
    final absPositions =
        shape.absPositions(base: absRefPosition.toPosition, direction: dir);
    if (state.arePositionsEmpty(absPositions)) {
      newAbsRefPosition = absRefPosition + dir.toPosition;
    }
    state.copyWith(activeShapePosition: newAbsRefPosition);
  }

  ///Rotates the Shape in a Certain Direction
  void rotateShape(Rotation rotation) {
    final shape = state.activeShape;
    final absRefPosition = state.activeShapePosition;
    if (shape == null || absRefPosition == null) return;
    final absPositions =
        shape.absPositions(base: absRefPosition.toPosition, rotation: rotation);
    if (state.arePositionsEmpty(absPositions)) {
      shape.rotateShape(rotation);
    }
    state.copyWith(activeShape: shape);
  }

  /*--------------------------------------------------------------------------*/
  /* Use cases (internal): Manipulating state for internal reasons            */
  /*--------------------------------------------------------------------------*/
  /// Moves a shape into Direction dir. It is usually invoked after an user input
  /// Clears one specific row
  /// No checks are performed, which is why the routine is private and
  /// should only be invoked after checking
  void _clearFullRow(int row) {
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

  /// Clear all rows which are currently filled
  /// (also checks if there are full rows at all)
  /// Private method because it'll be invoked as part of an automatic routine,
  /// not by anything external
  void _clearFullRows() {
    final fullRows = state.whichRowsAreFull()..sort((a, b) => b.compareTo(a));
    for (var row in fullRows) {
      _clearFullRow(row);
    }
  }

  /*--------------------------------------------------------------------------*/
  /* Use cases (informational): Translating state to the outside              */
  /*--------------------------------------------------------------------------*/
  /// Get the shape at a certain position (x,y)
  /// Returns null if no shape is presen
  Shape? getShapeAt(int x, int y) => state.grid[Position(x, y)];

  /// Get color of shape at a certain position (x,y)
  /// Returns null if no shape is presen
  Color? getShapeColor(int x, int y) => getShapeAt(x, y)?.color;
}
