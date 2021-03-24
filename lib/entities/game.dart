import 'dart:ffi';

import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/exactposition.dart';
import 'package:tetris/entities/grid.dart';
import 'package:tetris/entities/position.dart';
import 'package:tetris/entities/rotation.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeshop.dart';
import 'package:tetris/entities/direction.dart';

class Game {
  var shapeShop = ShapeShop();
  var grid = Grid();
  var actualSpeed = Constant.minSpeed;
  var lastTimeMoved;

  var activeShape;

  var activeShapeAbsExactPosition = ExactPosition(Constant.numCols/2,Constant.numRows.toDouble());

  Game() {
    spawnShape();
  }
  void spawnShape() {
    activeShape = shapeShop.giveShape();
    activeShapePosition = Position(shapeSpawnAbsPosition.x,shapeSpawnAbsPosition.y);
  }
  void moveShape(Direction direction,[Float distance]){
   distance ? distance = 1;
    var moveToExactPosition;
    if(direction == Direction.up   )
      moveToExactPosition = activeShapeAbsExactPosition+ExactPosition( distance,0);
    if(direction == Direction.down )
      moveToExactPosition = activeShapeAbsExactPosition+ExactPosition(-distance,0);
    if(direction == Direction.left )
      moveToExactPosition = activeShapeAbsExactPosition+ExactPosition(0,-distance);
    if(direction == Direction.right)
      moveToExactPosition = activeShapeAbsExactPosition+ExactPosition(0, distance);
    if(isPositionValid(activeShape,activeShapeAbsExactPosition,moveToExactPosition)){
      activeShapeAbsExactPosition+=moveToExactPosition;
    }
  }

  bool isPositionValid(Shape shape,ExactPosition exactAbsPosition, [Rotation rotateTo]{
    List<ExactPosition> absPositions;
    if(rotateTo != null){
      absPositions = shape.getRotatedState(exactAbsPosition, rotateTo);
    } else {
      absPositions = shape.getAbsPositions(exactAbsPosition);
    }
    List<ExactPosition> exactPositions = [];
    for (var absPosition in absPositions){
      exactAbsPosition.add(absPosition + exactAbsPosition);
    }
    List<ExactPosition> absExactPositions;
    for(Position cell in Grid){
      for(Position absPposition in) 
    }
  }

}
