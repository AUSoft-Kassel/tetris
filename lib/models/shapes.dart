import 'package:tetris/models/shape.dart';

import 'position.dart';

class ShapeO extends Shape {
  final List<List<Position>> _shapeStates = [
    [
      Position(0, 0),
      Position(0, 1),
      Position(1, 0),
      Position(1, -1),
    ],
  ]; // [0,0],[0,1],[1,0],[1,-1]

}
