import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/exactposition.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeshop.dart';
import 'package:tetris/entities/direction.dart';

// TODO: AH: Wir sollten versuchen, die Klasse immutable anzulegen, also
// sind per Definitionem alle Felder final. Wo es nicht klappt, helfe ich
// dann.
@immutable

///A class that handles the gamestate
class Game {
  /*--------------------------------------------------------------------------*/
  /* Attributes                                                               */
  /*--------------------------------------------------------------------------*/
  final ShapeShop _shapeShop; //private
  final Shape? _activeShape; //ro
  final ExactPosition? _activeShapePosition; //ro
  final Map<Position, Shape?> _grid; //ro
  final double _actualSpeed; //ro
  final int _points; //ro
  final Position _spawnPosition = Position((Constant.numCols / 2).floor(), Constant.numRows);

  /*--------------------------------------------------------------------------*/
  /* Constructors                                                             */
  /*--------------------------------------------------------------------------*/
  /// Standard constructor
  Game()
      : _shapeShop = ShapeShop(),
        _grid = <Position, Shape?>{},
        _actualSpeed = Constant.minSpeed,
        _points = 0,
        _activeShape = null,
        _activeShapePosition = null {
    log('Game constructed');
  }

  /// Internal constructor
  Game._internal({
    required ShapeShop shapeShop,
    required Shape? activeShape,
    required ExactPosition? activeShapePosition,
    required Map<Position, Shape?> grid,
    required double actualSpeed,
    required int points,
  })   : _shapeShop = shapeShop,
        _activeShape = activeShape,
        _activeShapePosition = activeShapePosition,
        _grid = grid,
        _actualSpeed = actualSpeed,
        _points = points;

  /*--------------------------------------------------------------------------*/
  /* Methods                                                                  */
  /*--------------------------------------------------------------------------*/
  /// Modifying state
  Game copyWith({
    ShapeShop? shapeShop,
    Shape? activeShape,
    ExactPosition? activeShapePosition,
    Map<Position, Shape?>? grid,
    double? actualSpeed,
    int? points,
  }) =>
      Game._internal(
        shapeShop: shapeShop ?? _shapeShop,
        activeShape: activeShape ?? _activeShape,
        activeShapePosition: activeShapePosition ?? _activeShapePosition,
        grid: grid ?? _grid,
        actualSpeed: actualSpeed ?? _actualSpeed,
        points: points ?? _points,
      );

  // void spawnShape() {
  //   _activeShape = _shapeShop.giveShape();
  //   _activeShapePosition = ExactPosition.clone(_spawnPosition);
  // }

  bool arePositionsValid(List<Position> positions) {
    for (var pos in positions) {
      if (isPositionValid(pos)) {
        return false;
      }
    }
    return true;
  }

  bool isPositionValid(Position pos) {
    if (_grid[pos] != null) {
      return false;
    }
    return true;
  }

  bool isRowFull(int row) {
    for (int i = 0; i < Constant.numCols; i++) {
      if (_grid[Position(i, row)] == null) {
        return false;
      }
    }
    return true;
  }

  List<int> whichRowsAreFull() {
    var result = <int>[];
    for (int i = 0; i < Constant.numRows; i++) {
      if (isRowFull(i)) {
        result.add(i);
      }
    }
    return result;
  }

  ///getters

  Map<Position, Shape?> get grid => _grid;
  Shape? get activeShape => _activeShape;
  ExactPosition? get activeShapePosition => _activeShapePosition;
  double get actualSpeed => _actualSpeed;
  int get points => _points;

  // /// Places the active Shape to the Grid
  // void addActiveShapeToGrid() {
  //   for (var position in _activeShape.absPositions(base: _activeShapePosition)) {
  //     _grid[position] = _activeShape;
  //   }
  //   spawnShape();
  // }

  // ///Moves the Active Shape
  // void moveShape(Direction direction, [double distance = 1]) {
  //   var moveToPosition = _activeShapePosition;

  //   if (direction == Direction.down)
  //     moveToPosition = ExactPosition(_activeShapePosition.x, (_activeShapePosition.y + distance).floor(), _activeShapePosition.y + distance);
  //   if (direction == Direction.left)
  //     moveToPosition = ExactPosition(_activeShapePosition.x - distance.floor(), _activeShapePosition.y, _activeShapePosition.yExact);
  //   if (direction == Direction.right)
  //     moveToPosition = ExactPosition(_activeShapePosition.x + distance.floor(), _activeShapePosition.y, _activeShapePosition.yExact);

  //   if (isPositionValid(moveToPosition)) {
  //     removeFromGrid();
  //     _activeShapePosition = moveToPosition;
  //     addActiveShapeToGrid();
  //   }
  // }
}
