import 'dart:ffi';

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
class Game {
  final ShapeShop _shapeShop = ShapeShop(); //private
  final late Shape _activeShape; //ro
  final late ExactPosition _activeShapePosition; //ro
  final Map _grid = Map<Position, Shape>(); //ro
  // shape2RedFosition{ShapeExact, Position} //ro
  final double _actualSpeed = Constant.minSpeed; //ro
  final int points; //ro

  final late ExactPosition _activeShapeAbsPosition;
  final Position _spawnPosition = Position((Constant.numCols / 2).floor(), Constant.numRows);

  Game(Shape activeShape, ExactPosition activeShapePosition, Map grid,
   double _actualSpeed, int points)
  : _activeShape = activeShape,
    _activeShapePosition = activeShapePosition;
    _grid = grid;
    _actualSpeed = actualSpeed;
    _points = points;
  {
    _activeShapePosition = _spawnPosition;
    spawnShape();
  };


  void spawnShape() {
    _activeShape = shapeShop.giveShape();
    _activeShapePosition.clone(_spawnPosition);
  }
    // }  // TODO: AH: Außerdem wird bei dem aktiven Shape ja die ExactPositon
    // gespeichert. Folglich müssen wir keine Umrechnung auf Position vornehmen
    //   activeShapePosition = ExactPosition.clone(spawnPosition)
    // Der Konstruktor .clone müsste in ExactPosition definiert sein und
    // er kopiert einfach die werte aus einer mitgegebenen ExactPosition.
    // Warum nicht einfach activeShapePosition = spawnPosition?
    // Weil das bedeuten würde, dass einfach eine Referenz auf die
    // spawnPosition übergeben würde. Änderungen an activeShapePosition
    // würden spawnPosition verändern! Bei uns wäre die Auswirkung allerdings
    // wohl relativ neu, weil wir nie etwas ändern, sondern nur neue
    // Objekte erstellen (immutable state).
    bool isPositionValid(ExactPosition moveToPosition,
        [Rotation rotation = Rotation.none]) {
      bool isValid = false;

      List<Position> absPositions = _activeShape.getAbsPositions(
          base: Position(moveToPosition.x,moveToPosition.y), rotation: rotation);

      for (var absPosition in absPositions) {
        if (grid[absPosition] is Shape && grid[absPosition] != _activeShape)
          isValid = true;
      }
      return isValid;
    }

    void removeFromGrid() {
      grid.remove(_activeShape);
    }

    void addActiveShapeToGrid() {
      for (Position position
          in _activeShape.getAbsPositions(base: _activeShapePosition)) {
        grid[position] = _activeShape;
      }
    }


    void moveShape(Direction direction, [num distance = 1]) {
      ExactPosition moveToPosition;

      if (direction == Direction.down)
        moveToPosition = ExactPosition(_activeShapePosition.x,_activeShapePosition.y.floor+distance,_activeShapePosition.y.floor+distance);
      if (direction == Direction.left)
        moveToPosition = ExactPosition(_activeShapePosition.x-distance,_activeShapePosition.y,_activeShapePosition.yExact);
      if (direction == Direction.right)
        moveToPosition = ExactPosition(_activeShapePosition.x+distance,_activeShapePosition.y,_activeShapePosition.yExact);

      if (isPositionValid(moveToPosition)) {
        removeFromGrid();
        _activeShapePosition = moveToPosition;
        addActiveShapeToGrid();
      }
    }
  }
}
