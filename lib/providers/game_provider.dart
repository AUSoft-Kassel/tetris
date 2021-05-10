import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/direction.dart';
import 'package:tetris/entities/game.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/providers/_providers.dart';

/// GameProvider is a StateNotifier
/// It always hold a reference to the currently active state of the underlying
/// Game object, which is accessible through its state attribute (which is
/// defined in StateNotifier class). Upon creation, it creates a standard
/// Game object. Every change of state must be achieved through a reassignment
/// of the state attribute to a new object of type Game.
class GameProvider extends StateNotifier<Game> {
  /// Standard constructor. A Game object is created and handed to the super
  /// class where it gets stored in the state attribute.
  GameProvider() : super(Game(false));

  final _sounds = ProviderContainer().read(providerSoundProvider);
  int _currentGameLoopId = 0;

  /*--------------------------------------------------------------------------*/
  /* Use cases (external): Manipulating state for external reasons            */
  /*--------------------------------------------------------------------------*/
  /// Moves active shape into Direction dir.
  /// It is usually invoked after an user input.
  void moveActiveShape(Direction dir) {
    if (state.gameRunning == false) return;
    final shape = state.activeShape;
    final absRefPosition = state.activeShapePosition;
    var newAbsRefPosition = absRefPosition;
    if (shape == null || absRefPosition == null) return;
    final absPositions =
        shape.absolutePositions(base: absRefPosition, direction: dir);
    if (_arePositionsInGrid(absPositions)) {
      if (_arePositionsEmpty(absPositions)) {
        newAbsRefPosition = absRefPosition + dir.toPosition;
        state = state.copyWith(activeShapePosition: newAbsRefPosition);
        return;
      }
    }
    if (dir == Direction.down) {
      _sounds.playShapeSetOnGround();
      _spawnNextShape();
    }
  }

  ///Rotates the Shape in a Certain Direction
  void rotateActiveShape(Rotation rotation) {
    final shape = state.activeShape;
    final absRefPosition = state.activeShapePosition;
    if (shape == null || absRefPosition == null) return;
    final absPositions =
        shape.absolutePositions(base: absRefPosition, rotation: rotation);
    if (_arePositionsInGrid(absPositions)) {
      if (_arePositionsEmpty(absPositions)) {
        _sounds.playSoundRotate(rotation);
        shape.rotateShape(rotation);
        state = state.copyWith();
      }
    }
  }

  /// Start a Game round
  void startGame() {
    state = Game(true);
    _spawnNextShape();
    _currentGameLoopId++;
    Future.delayed(_getDelay(), () {
      _gameLoop(_currentGameLoopId);
    });
  }

  void _gameLoop(int thisGameLoopId) {
    if (state.gameRunning == false || _currentGameLoopId > thisGameLoopId)
      return;

    moveActiveShape(Direction.down);
    Future.delayed(_getDelay(), () {
      _gameLoop(thisGameLoopId);
    });
  }

  Duration _getDelay() => Duration(milliseconds: 1000 ~/ state.actualSpeed);

  /*--------------------------------------------------------------------------*/
  /* Use cases (internal): Manipulating state for internal reasons            */
  /*--------------------------------------------------------------------------*/
  void _addActiveShapeToGrid() {
    var positions = state.activeShape
            ?.absolutePositions(base: state.activeShapePosition!) ??
        [];
    var newGrid = <Position, Shape?>{};
    state.grid.forEach((pos, shape) {
      newGrid[pos] = shape;
    });
    for (var pos in positions) {
      newGrid[pos] = state.activeShape;
    }
    state = state.copyWith(grid: newGrid);
  }

  void _addPoints(int points) {
    state = state.copyWith(points: state.points + points);
  }

  void _addPointsForClearedRows(int rows) {
    if (rows == 1) _addPoints(10 * (state.level ~/ 4 + 1));
    if (rows == 2) _addPoints(25 * (state.level ~/ 4 + 1));
    if (rows == 3) _addPoints(50 * (state.level ~/ 4 + 1));
    if (rows == 4) _addPoints(100 * (state.level ~/ 4 + 1));
  }

  /// Clear all rows which are currently filled.
  void _clearAllFullRows() {
    /// Find out which rows are full
    final fullRows = <int>[];
    for (var i = 0; i < Constant.numRows; i++) {
      if (_isRowFull(i)) {
        fullRows.add(i);
      }
    }
    if (fullRows.isNotEmpty) {
      // Sort lines because we have to delete higher lines before we delete
      // lower lines
      fullRows.sort((a, b) => b.compareTo(a));

      state = state.copyWith(linesToBeDeleted: fullRows);

      _addPointsForClearedRows(fullRows.length);

      Future.delayed(Duration(milliseconds: 1000), () {
        for (var row in fullRows) {
          _clearFullRow(row);
        }
        _sounds.playSoundDestroy(fullRows.length);

        state = state.copyWith(linesToBeDeleted: []);
      });
    }
  }

  /// Clears one specific row. No checks are performed, which is why the routine
  /// is private and should only be invoked after checking
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

  void _spawnNextShape() {
    // log('SpawnNextShape: 1: ${state.shapeShop.currentBag.length} / ${state.shapeShop.nextBag.length}');
    final nextShape = state.shapeShop.giveShape();
    // log('SpawnNextShape: 2: ${state.shapeShop.currentBag.length} / ${state.shapeShop.nextBag.length}');
    final nextShapesPlaced = state.shapesPlaced + 1;
    final int nextLevel;
    if (state.level < Constant.maxLevel)
      nextLevel = nextShapesPlaced ~/ Constant.shapesPerLevel;
    else
      nextLevel = state.level;
    final nextSpeed = Constant.minSpeed + Constant.speedPerLevel * nextLevel;
    final nextShapePosition = Constant.spawnPosition;

    var gameRunning = state.gameRunning;
    if (state.actualSpeed ~/ 1 < nextSpeed ~/ 1) {
      _sounds.playSoundDifficultyUp();
    }
    _addActiveShapeToGrid();
    if (_arePositionsEmpty(
        nextShape.absolutePositions(base: nextShapePosition))) {
      _clearAllFullRows();
      _sounds.playSoundSpawnOfShapes();
    } else if (gameRunning == true) {
      gameRunning = false;
      _sounds.playSoundGameover();
    }
    state = state.copyWith(
      activeShape: nextShape,
      activeShapePosition: nextShapePosition,
      shapesPlaced: nextShapesPlaced,
      level: nextLevel,
      actualSpeed: nextSpeed,
      gameRunning: gameRunning,
    );
    // log('SpawnNextShape: 3: ${state.shapeShop.currentBag.length} / ${state.shapeShop.nextBag.length}');
  }

  /*--------------------------------------------------------------------------*/
  /* Use cases (informational): Translating state to the outside              */
  /*--------------------------------------------------------------------------*/
  /// Get the shape at a certain position. Returns null if no shape is present.
  Shape? getShapeAt(Position pos) {
    final inactiveShape = state.grid[pos];
    if (inactiveShape != null)
      return inactiveShape; // Inactive shape if found at pos
    final activeShape = state.activeShape;
    if (activeShape == null) return null; // null if no activeShape at all
    final activeShapePositions =
        activeShape.absolutePositions(base: state.activeShapePosition!);
    for (var activeShapePos in activeShapePositions) {
      if (activeShapePos == pos)
        return activeShape; // activeShape if found at pos
    }
    return null; // null if nothing else
  }

  /// Get color of shape at a certain position (or null if no shape is present)
  Color? getShapeColorAt(Position pos) {
    final shape = getShapeAt(pos);
    if (shape == null) return null;
    return Color(shape.color);
  }

  /*--------------------------------------------------------------------------*/
  /* Methods for getting further data from Game objects                       */
  /* (These methods could also be located in GameProvider)                    */
  /*--------------------------------------------------------------------------*/
  /// Creates a new Game object which is a copy of this Game object, except
  /// for the attributes which are provided as arguments to this method
  ///Checks if a List of Positions are Empty
  bool _arePositionsEmpty(List<Position> positions) {
    for (var pos in positions) {
      if (_isPositionEmpty(pos) == false) return false;
    }
    return true;
  }

  Direction _oppositeHorizontalDirection(Position pos) {
    Direction? dir;
    if (pos.x > 0) dir = Direction.left;
    return dir ??= Direction.right;
  }

  Position _wichPositionIsInvalid(List<Position> positions) {
    Position? position;
    for (var pos in positions) {
      if (_isPositionEmpty(pos) == false) position = pos;
    }

    for (var pos in positions) {
      if (pos.x < 0) return position = pos;
      if (pos.y < 0) return position = pos;
      if (pos.x >= Constant.numCols) return position = pos;
      // if (pos.y >= Constant.numRows) return false;
    }
    if (position == null) {
      log('Invalid useage of _wichPositionIsInvalid.');
      log('Be sure any Position is invalid.');
      position = const Position(0, 0);
    }
    return position;
  }

  /// Returns true if every position is still on the grid
  bool _arePositionsInGrid(List<Position> positions) {
    for (var pos in positions) {
      if (pos.x < 0) return false;
      if (pos.y < 0) return false;
      if (pos.x >= Constant.numCols) return false;
      // if (pos.y >= Constant.numRows) return false;
    }
    return true;
  }

  /// Check if a certain position is Empty
  bool _isPositionEmpty(Position pos) {
    if (state.grid[pos] == null) return true;
    return false;
  }

  ///Returns true if the Row is Full
  bool _isRowFull(int row) {
    for (var i = 0; i < Constant.numCols; i++) {
      if (state.grid[Position(i, row)] == null) {
        return false;
      }
    }
    return true;
  }

  bool isRowToClear(int row) {
    for (var rowToClear in state.rowsToClear) {
      if (row == rowToClear) return true;
    }
    return false;
  }

  ///Returns a List of all parts of the active shape in absPosition
  List<Position>? activeShapePositions() =>
      state.activeShape?.absolutePositions(
          base: state.activeShapePosition ?? const Position(0, 0));
}
