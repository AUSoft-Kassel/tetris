import 'package:tetris/entities/position.dart';

/// Description of the class which define all relative positions in one rotation of a shape
class RelRotatedpositions {
  List<Position> _position = [];

  ///setter
  void addPos(Position pos) {
    _position.add(pos);
  }

  ///getter
  Position getPos(int i) => _position[i];
}
