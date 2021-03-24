import 'package:tetris/entities/constant.dart';
import 'package:tetris/entities/shape.dart';
import 'package:tetris/entities/shapeshop.dart';
import 'package:tetris/entities/direction.dart';

class Game {
  var shapeShop = ShapeShop();

  var actualSpeed = Constant.minSpeed;
  var lastTimeMoved

  var activeShape;
  var activeShapeAbsExactPosition; 

  final activeShapeAbsExactPosition = ExactPosition(Constant.numColums/2,Constant.numRows);

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
      moveToExactPosition = activeShapeAbsExactPosition+Position( distance,0);
    if(direction == Direction.down )
      moveToExactPosition = activeShapeAbsExactPosition+Position(-distance,0);
    if(direction == Direction.left )
      moveToExactPosition = activeShapeAbsExactPosition+Position(0,-distance);
    if(direction == Direction.right)
      moveToExactPosition = activeShapeAbsExactPosition+Position(0, distance);
    if(isPositionValid(activeShape,activeShapeAbsExactPosition,moveToExactPosition)){
      activeShapeAbsExactPosition+=moveToExactPosition;
    }
  }

  bool isPositionValid(Shape shape,ExactPosition exactPosition, [Rotation rotateTo]{
    if(rotateTo != null){
      List<Position> relPositions = shape.getRotatedState(rotateTo);
    } else {
      List<Position> relPositions = shape.getCurrentState();
    }
    List<ExactPosition> exactPositions = [];
    for(Position relPosition in relPositions){
      exactPositions.add(relPosition + exactPosition)
    }
    List<ExactPosition> absExactPositions
    for(Position cell in grid){
      for(Position relPposition in)
    }
  }

}
