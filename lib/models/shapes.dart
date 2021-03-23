import 'package:models/position.dart';
class Shape_O : include Shape{
  final List<List<Position>> _shapeStates = [
  [
    Position(0,0),
    Position(0,1),
    Position(1,0),
    Position(1,-1),
  ],
]; // [0,0],[0,1],[1,0],[1,-1]

}

