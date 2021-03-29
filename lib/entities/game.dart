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
  // ignore: unused_field
  final ShapeShop _shapeShop = ShapeShop(); //private
  late final Shape _activeShape; //ro
  late final ExactPosition _activeShapePosition; //ro
  late final Map<Position, Shape> _grid; //ro
  // shape2RedFosition{ShapeExact, Position} //ro
  // ignore: unused_field
  final double _actualSpeed = Constant.minSpeed; //ro
  // ignore: unused_field
  final int _points = 0; //ro

  final Position _spawnPosition =
      Position((Constant.numCols / 2).floor(), Constant.numRows);

  ///Constructor
  Game() {
    _activeShapePosition = ExactPosition.clone(ExactPosition(1, 0, 0));
    spawnShape();
  }

  void spawnShape() {
    _activeShape = _shapeShop.giveShape();
    _activeShapePosition = ExactPosition.clone(_spawnPosition);
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

    List<Position> absPositions = _activeShape.absPositions(
        base: Position(moveToPosition.x, moveToPosition.y), rotation: rotation);

    for (var absPosition in absPositions) {
      if (_grid[absPosition] is Shape && _grid[absPosition] != _activeShape)
        isValid = true;
    }
    return isValid;
  }

  void removeFromGrid() {
    _grid.remove(_activeShape);
  }

  ///Places the active Shape to the Grid
  void addActiveShapeToGrid() {
    for (var position
        in _activeShape.absPositions(base: _activeShapePosition)) {
      _grid[position] = _activeShape;
    }
  }

  ///Moves the Active Shape
  void moveShape(Direction direction, [double distance = 1]) {
    var moveToPosition = _activeShapePosition;

    if (direction == Direction.down)
      moveToPosition = ExactPosition(
          _activeShapePosition.x,
          (_activeShapePosition.y + distance).floor(),
          _activeShapePosition.y + distance);
    if (direction == Direction.left)
      moveToPosition = ExactPosition(_activeShapePosition.x - distance.floor(),
          _activeShapePosition.y, _activeShapePosition.yExact);
    if (direction == Direction.right)
      moveToPosition = ExactPosition(_activeShapePosition.x + distance.floor(),
          _activeShapePosition.y, _activeShapePosition.yExact);

    if (isPositionValid(moveToPosition)) {
      removeFromGrid();
      _activeShapePosition = moveToPosition;
      addActiveShapeToGrid();
    }
  }
}
