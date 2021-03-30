import 'package:flutter/foundation.dart';
import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/exactposition.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeshop.dart';

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
  final Position _spawnPosition =
      Position((Constant.numCols / 2).floor(), Constant.numRows);

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
        _activeShapePosition = null;

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

  ///Checks if a List of Positions are Empty
  bool arePositionsEmpty(List<Position> positions) {
    bool isValid;
    for (var pos in positions) {
      isValid = isPositionEmpty(pos);
      if (!isValid) return false;
    }
    return true;
  }

  /// Check if a certain position is Empty
  bool isPositionEmpty(Position pos) {
    if (shapeFromGrid(pos) != null) return false;
    return true;
  }

  /// Gets the Shape of a certain position
  Shape? shapeFromGrid(Position pos) {
    final shape = _grid[pos];
    return shape;
  }

  /// Returns true if the Row is full
  bool isRowFull(int row) {
    for (var i = 0; i < Constant.numCols; i++) {
      if (_grid[Position(i, row)] == null) {
        return false;
      }
    }
    return true;
  }

  ///Returns a list of Full Rows
  List<int> whichRowsAreFull() {
    final result = <int>[];
    for (var i = 0; i < Constant.numRows; i++) {
      if (isRowFull(i)) {
        result.add(i);
      }
    }
    return result;
  }

  /*--------------------------------------------------------------------------*/
  /* getters                                                                  */
  /*--------------------------------------------------------------------------*/
  /// A Map with key of type Position and Value of Shape
  Map<Position, Shape?> get grid => _grid;

  /// The actual Moveable Shape
  Shape? get activeShape => _activeShape;

  /// Represents the relative(0,0) position in the absolute grid
  ExactPosition? get activeShapePosition => _activeShapePosition;

  /// Fallingspeed of the active Shape
  double get actualSpeed => _actualSpeed;

  /// Score
  int get points => _points;
}
