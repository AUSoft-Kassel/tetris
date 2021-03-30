import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/exactposition.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeshop.dart';

// AH: I had to remove this, because our core entities should be
// completely independent of anything. Immutable annotation is defined in
// flutter-foundation ... Not acceptable. Now that we got rid of this
// dependency, we can easily switch the framework
//@immutable

/// Class that holds the state of the game
/// Objects are immutable, so no changes occur in this class, because all
/// variables are final
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
  /// Constructs quite an empty game
  Game()
      : _shapeShop = ShapeShop(),
        _grid = <Position, Shape?>{},
        _actualSpeed = Constant.minSpeed,
        _points = 0,
        _activeShape = null,
        _activeShapePosition = null;

  /// Internal constructor
  /// Used for creating a specific instance of Game
  /// Only used by copyWith
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
  /// Creates a new Game object which is a copy of this Game object, except
  /// for the attributes which are provided as arguments to this method
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

  /*--------------------------------------------------------------------------*/
  /* Getters (everything we need to access in GameProvider)                   */
  /*--------------------------------------------------------------------------*/
  /// Grid that holds all information about shapes on the field
  Map<Position, Shape?> get grid => _grid;

  /// Currently active shape
  Shape? get activeShape => _activeShape;

  /// Position of currently active shape
  ExactPosition? get activeShapePosition => _activeShapePosition;

  /// Game speed
  double get actualSpeed => _actualSpeed;

  /// Points within the current game
  int get points => _points;

  /// Position at which new shapes are spawned
  Position get spawnPosition => _spawnPosition;

  /*--------------------------------------------------------------------------*/
  /* Methods for getting further data from Game objects                       */
  /* (These methods could also be located in GameProvider)                    */
  /*--------------------------------------------------------------------------*/
  /// Creates a new Game object which is a copy of this Game object, except
  /// for the attributes which are provided as arguments to this method
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
}

///getters

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
