import 'package:flutter/cupertino.dart';

/// Description of the class which define our position
@immutable
class Position {
/*-----------------------------------------------------------------------------\
| Attributes                                                                   |
\-----------------------------------------------------------------------------*/
  final int _x;

  final int _y;

  final double _yExact;

/*-----------------------------------------------------------------------------\
| Constructors                                                                 |
\-----------------------------------------------------------------------------*/
  /// Constructs Position object using rounded y coordinate
  Position(int x, int y)
      : _x = x,
        _y = y,
        _yExact = y.toDouble();

  /// Constructs Position object using exact y coordinate
  Position.exact(int x, double yExact)
      : _x = x,
        _yExact = yExact,
        _y = yExact.round();

/*-----------------------------------------------------------------------------\
| Getters / Setters                                                            |
\-----------------------------------------------------------------------------*/
  /// Describes in which row position the position is located
  int get x => _x;

  /// Describes in which column position the position is located
  int get y => _y;

  /// Describes in which column (including fractions of a column) the position is located
  double get yExact => _yExact;

  @override
  bool operator ==(Object o) => o is Position && o.y == _y && o.x == _x;

  @override
  int get hashCode => _x * 1000 + _y;
}
