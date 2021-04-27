import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeshop.dart';

/// Class that holds the state of the game
/// Objects are immutable, so no changes occur in this class, because all
/// variables are final. Pure data class.
class Game {
  /*--------------------------------------------------------------------------*/
  /* Attributes                                                               */
  /*--------------------------------------------------------------------------*/
  final ShapeShop _shapeShop;
  final Shape? _activeShape;
  final Position? _activeShapePosition;
  final Map<Position, Shape?> _grid;
  final double _actualSpeed;
  final int _points;
  final bool _gameRunning;
  final int _level;
  final int _shapesPlaced;

  /*--------------------------------------------------------------------------*/
  /* Constructors                                                             */
  /*--------------------------------------------------------------------------*/
  /// Standard constructor
  /// Constructs quite an empty game
  // ignore: avoid_positional_boolean_parameters
  Game(bool gameRunning)
      : _shapeShop = ShapeShop(),
        _grid = <Position, Shape?>{},
        _actualSpeed = Constant.minSpeed,
        _points = 0,
        _activeShape = null,
        _activeShapePosition = null,
        _gameRunning = gameRunning,
        _level = 1,
        _shapesPlaced = 0;

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
    required int level,
    required int shapesPlaced,
  })   : _shapeShop = shapeShop,
        _activeShape = activeShape,
        _activeShapePosition = activeShapePosition,
        _grid = grid,
        _actualSpeed = actualSpeed,
        _points = points,
        _gameRunning = gameRunning,
        _level = level,
        _shapesPlaced = shapesPlaced;

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
    int? level,
    int? shapesPlaced,
  }) =>
      Game._internal(
        shapeShop: shapeShop ?? _shapeShop,
        activeShape: activeShape ?? _activeShape,
        activeShapePosition: activeShapePosition ?? _activeShapePosition,
        grid: grid ?? _grid,
        actualSpeed: actualSpeed ?? _actualSpeed,
        points: points ?? _points,
        gameRunning: gameRunning ?? _gameRunning,
        level: level ?? _level,
        shapesPlaced: shapesPlaced ?? _shapesPlaced,
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

  /// Handeling the shape output.
  ShapeShop get shapeShop => _shapeShop;

  /// Returns true if game is running
  bool get gameRunning => _gameRunning;

  /// Returns level
  int get level => _level;

  /// Returns shapes placed
  int get shapesPlaced => _shapesPlaced;
}
