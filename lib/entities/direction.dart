import 'package:tetris/entities/position.dart';

/// Moving direction of the shape
enum Direction {
  /// Direction up
  up,

  /// Direction down
  down,

  /// Direction left
  left,

  /// Direction right
  right,
}

/// Extension to Direction
extension DirectionExtension on Direction {
  /// Returns direction vector as Position
  Position get toPosition {
    if (this == Direction.up) {
      return const Position(0, 1);
    }
    if (this == Direction.down) {
      return const Position(0, -1);
    }
    if (this == Direction.left) {
      return const Position(-1, 0);
    }
    if (this == Direction.right) {
      return const Position(1, 0);
    }
    return const Position(0, 0);
  }
}
