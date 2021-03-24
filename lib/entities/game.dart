import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/grid.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeshop.dart';
import 'package:tetris/entities/direction.dart';

///Discripes the Game class
class Game {
  final ShapeShop _shapeShop = ShapeShop();
  final Grid _grid = Grid();
  var _actualSpeed = Constant.minSpeed;
  DateTime _lastTimeMoved = DateTime.now();

  var _activeShape;

  final Position _startPosition =
      Position((Constant.numCols / 2).floor(), Constant.numRows);

  ///Contructos
  Game() {
    spawnShape();
  }

  void spawnShape() {
    _activeShape = _shapeShop.giveShape();
  }

  void moveShape(Direction direction) {
    if (isMoveValid()) {
      ///moves the shape
    }
  }

  ///Checks if the Move is Valis
  bool isMoveValid() {
    ///insert check routine
    return true;
  }
}
