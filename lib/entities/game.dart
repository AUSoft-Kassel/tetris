import 'package:tetris/entities/constant.dart';
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
  final Position? _activeShapePosition; //ro
  final Map<Position, Shape?> _grid; //ro
  final double _actualSpeed; //ro
  final int _points; //ro
  final bool _gameRunning; //ro

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
        _activeShapePosition = null,
        _gameRunning = false;

  /// Internal constructor
  /// Used for creating a specific instance of Game
  /// Only used by copyWith
  Game._internal({
    required ShapeShop shapeShop,
    required Shape? activeShape,
    required Position? activeShapePosition,
    required Map<Position, Shape?> grid,
    required double actualSpeed,
    required int points,
    required bool gameRunning,
  })   : _shapeShop = shapeShop,
        _activeShape = activeShape,
        _activeShapePosition = activeShapePosition,
        _grid = grid,
        _actualSpeed = actualSpeed,
        _points = points,
        _gameRunning = gameRunning;

  /*--------------------------------------------------------------------------*/
  /* Methods                                                                  */
  /*--------------------------------------------------------------------------*/
  /// Creates a new Game object which is a copy of this Game object, except
  /// for the attributes which are provided as arguments to this method
  Game copyWith({
    ShapeShop? shapeShop,
    Shape? activeShape,
    Position? activeShapePosition,
    Map<Position, Shape?>? grid,
    double? actualSpeed,
    int? points,
    bool? gameRunning,
  }) =>
      Game._internal(
        shapeShop: shapeShop ?? _shapeShop,
        activeShape: activeShape ?? _activeShape,
        activeShapePosition: activeShapePosition ?? _activeShapePosition,
        grid: grid ?? _grid,
        actualSpeed: actualSpeed ?? _actualSpeed,
        points: points ?? _points,
        gameRunning: gameRunning ?? _gameRunning,
      );

  /*--------------------------------------------------------------------------*/
  /* Getters (everything we need to access in GameProvider)                   */
  /*--------------------------------------------------------------------------*/
  /// Grid that holds all information about shapes on the field
  Map<Position, Shape?> get grid => _grid;

  /// Currently active shape
  Shape? get activeShape => _activeShape;

  /// Position of currently active shape
  Position? get activeShapePosition => _activeShapePosition;

  /// Game speed
  double get actualSpeed => _actualSpeed;

  /// Points within the current game
  int get points => _points;

  ///Handeling the shape output.
  ShapeShop get shapeShop => _shapeShop;

  // Returns true if game is running
  bool get gameRunning => _gameRunning;

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

  /// Returns true if every position is still on the grid
  bool arePositionsInGrid(List<Position> positions) {
    for (var pos in positions) {
      if (pos.x < 0) return false;
      if (pos.y < 0) return false;
      if (pos.x >= Constant.numCols) return false;
      // if (pos.y >= Constant.numRows) return false;
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

  ///Returns true if the Row is Full
  bool isRowFull(int row) {
    for (var i = 0; i < Constant.numCols; i++) {
      if (_grid[Position(i, row)] == null) {
        return false;
      }
    }
    return true;
  }

  ///Retruns a list of full Rows
  List<int> whichRowsAreFull() {
    final result = <int>[];
    for (var i = 0; i < Constant.numRows; i++) {
      if (isRowFull(i)) {
        result.add(i);
      }
    }
    return result;
  }

  ///Returns a List of all parts of the active shape in absPosition
  List<Position>? activeShapePositions() => _activeShape?.absPositions(base: activeShapePosition ?? const Position(0, 0));
}
